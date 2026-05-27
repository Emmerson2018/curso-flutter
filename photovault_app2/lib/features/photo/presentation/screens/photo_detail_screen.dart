import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/tts/tts_service.dart';
import '../providers/photo_providers.dart';
import '../widgets/audio_controls.dart';
import '../../domain/entities/photo.dart';

class PhotoDetailScreen extends ConsumerStatefulWidget {
  final Photo photo;
  const PhotoDetailScreen({super.key, required this.photo});
  @override
  ConsumerState<PhotoDetailScreen> createState() => _PhotoDetailState();
}

class _PhotoDetailState extends ConsumerState<PhotoDetailScreen> {
  late final _captionCtrl   =
      TextEditingController(text: widget.photo.caption);
  late final _audioDescCtrl =
      TextEditingController(text: widget.photo.audioDescription);
  bool _editing = false;

  @override
  void dispose() {
    _captionCtrl.dispose();
    _audioDescCtrl.dispose();
    ref.read(ttsServiceProvider).stop();
    super.dispose();
  }

  Future<void> _save() async {
    final repo = await ref.read(photoRepositoryProvider.future);
    await repo.updatePhotoMeta(
      widget.photo.id,
      caption:          _captionCtrl.text,
      audioDescription: _audioDescCtrl.text,
    );
    setState(() => _editing = false);
  }

  @override
  Widget build(BuildContext context) {
    final tts = ref.watch(ttsServiceProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: MediaQuery.sizeOf(context).height * .5,
          pinned: true,
          backgroundColor: Colors.black,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: 'photo_${widget.photo.id}',
              child: widget.photo.remoteUrl != null
                  ? CachedNetworkImage(
                      imageUrl: widget.photo.remoteUrl!,
                      fit: BoxFit.contain)
                  : Image.file(
                      File(widget.photo.localPath),
                      fit: BoxFit.contain),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                  _editing ? Icons.save : Icons.edit,
                  color: Colors.white),
              tooltip: _editing ? 'Salvar' : 'Editar',
              onPressed:
                  _editing ? _save : () => setState(() => _editing = true),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AudioControls(
                onPlay:  () => tts.speakPhoto(widget.photo),
                onPause: () => tts.pause(),
                onStop:  () => tts.stop(),
              ),
              const SizedBox(height: 20),
              const Text('Legenda',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              _editing
                  ? TextField(
                      controller: _captionCtrl,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Adicione uma legenda...',
                        hintStyle: TextStyle(color: Colors.white38),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white30))))
                  : Text(
                      _captionCtrl.text.isEmpty
                          ? 'Sem legenda'
                          : _captionCtrl.text,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 16)),
              const SizedBox(height: 20),
              const Text('Audiodescrição',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              _editing
                  ? TextField(
                      controller: _audioDescCtrl,
                      maxLines: 5,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Descreva a imagem para audiodescrição...',
                        hintStyle: TextStyle(color: Colors.white38),
                        border: OutlineInputBorder(),
                        helperText: 'Lido pelo leitor de tela',
                        helperStyle: TextStyle(color: Colors.white38),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white30))))
                  : Text(
                      _audioDescCtrl.text.isEmpty
                          ? 'Sem audiodescrição'
                          : _audioDescCtrl.text,
                      style: const TextStyle(color: Colors.white70)),
            ]),
          ),
        ),
      ]),
    );
  }
}
