import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});
  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {

  CameraController? _ctrl;
  List<CameraDescription> _cameras = [];
  bool _isCapturing = false;
  int  _camIdx = 0;  // 0=traseira, 1=frontal

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) await _setupCamera(_cameras[_camIdx]);
  }

  Future<void> _setupCamera(CameraDescription cam) async {
    final c = CameraController(cam, ResolutionPreset.high, enableAudio: false);
    await c.initialize();
    if (mounted) setState(() => _ctrl = c);
  }

  Future<void> _capture() async {
    if (_ctrl == null || _isCapturing) return;
    setState(() => _isCapturing = true);
    try {
      final xFile = await _ctrl!.takePicture();
      final docDir = await getApplicationDocumentsDirectory();
      final id     = const Uuid().v4();
      final dest   = path.join(docDir.path, 'photos', '$id.jpg');
      await Directory(path.dirname(dest)).create(recursive: true);
      await File(xFile.path).copy(dest);

      final photo = Photo(id: id, localPath: dest, createdAt: DateTime.now());
      await ref.read(photoGalleryProvider.notifier).addPhoto(photo);
      if (mounted) Navigator.pop(context, photo);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  Future<void> _pickFromGallery() async {
    final file = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 85);
    if (file == null || !context.mounted) return;
    final photo = Photo(
        id: const Uuid().v4(), localPath: file.path, createdAt: DateTime.now());
    await ref.read(photoGalleryProvider.notifier).addPhoto(photo);
    if (context.mounted) Navigator.pop(context, photo);
  }

  // Pausa a câmera quando app vai para background
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_ctrl == null) return;
    if (state == AppLifecycleState.inactive) {
      _ctrl!.dispose();
    } else if (state == AppLifecycleState.resumed)   _setupCamera(_cameras[_camIdx]);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ctrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_ctrl == null || !_ctrl!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        // Preview da câmera ocupa a tela toda
        SizedBox.expand(child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width:  _ctrl!.value.previewSize!.height,
            height: _ctrl!.value.previewSize!.width,
            child:  CameraPreview(_ctrl!)),
        )),
        // Botões na parte inferior
        Positioned(bottom: 48, left: 0, right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: const Icon(Icons.photo_library, color: Colors.white, size: 32),
                  onPressed: _pickFromGallery, tooltip: 'Galeria'),
              // Botão de captura
              GestureDetector(onTap: _capture,
                child: Container(width: 72, height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    color: _isCapturing ? Colors.white38 : Colors.white.withValues(alpha: .9)),
                  child: _isCapturing ? const CircularProgressIndicator() : const SizedBox.shrink(),
                )),
              IconButton(icon: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 32),
                  onPressed: _cameras.length > 1 ? () async {
                    await _ctrl?.dispose();
                    setState(() => _camIdx = _camIdx == 0 ? 1 : 0);
                    await _setupCamera(_cameras[_camIdx]);
                  } : null, tooltip: 'Virar câmera'),
            ],
          ),
        ),
        SafeArea(child: Align(alignment: Alignment.topLeft,
          child: IconButton(icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context)))),
      ]),
    );
  }
}