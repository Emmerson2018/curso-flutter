import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../providers/photo_providers.dart';
import '../widgets/photo_tile.dart';
import 'camera_screen.dart';
import 'search_screen.dart';
import '../../../settings/presentation/settings_screen.dart';

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(photoGalleryStreamProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text('PhotoVault',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          pinned: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SearchScreen())),
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen())),
            ),
          ],
        ),
        photosAsync.when(
          loading: () => const SliverFillRemaining(
              child: Center(
                  child: CircularProgressIndicator(color: Colors.white))),
          error: (e, st) => SliverFillRemaining(
              child: Center(
                  child: Text('Erro: $e',
                      style: const TextStyle(color: Colors.white)))),
          data: (photos) => photos.isEmpty
              ? const SliverFillRemaining(child: _EmptyGallery())
              : SliverPadding(
                  padding: const EdgeInsets.all(2),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) => PhotoTile(photo: photos[i]),
                      childCount: photos.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                    ),
                  )),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.camera_alt, color: Colors.black),
        onPressed: () async {
          final status = await Permission.camera.request();
          if (status.isGranted && context.mounted) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CameraScreen()));
          }
        },
      ),
    );
  }
}

class _EmptyGallery extends StatelessWidget {
  const _EmptyGallery();
  @override
  Widget build(BuildContext context) => const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.photo_library_outlined, size: 80, color: Colors.grey),
      SizedBox(height: 16),
      Text('Galeria vazia',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Toque na câmera para começar',
          style: TextStyle(color: Colors.grey)),
    ],
  );
}
