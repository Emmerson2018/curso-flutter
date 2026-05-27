import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/photo_providers.dart';
import '../screens/photo_detail_screen.dart';
import '../../domain/entities/photo.dart';
import 'photo_tile.dart';

class GalleryBody extends ConsumerWidget {
  const GalleryBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch → observa; reconstrói quando muda — use SEMPRE no build()
    final photosAsync = ref.watch(photoGalleryStreamProvider);

    return photosAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error:   (e, _) => _ErrorView(
          mensagem: e.toString(),
          onRetry: () => ref.invalidate(photoGalleryStreamProvider)),
      data:    (photos) => photos.isEmpty
          ? const _EmptyState()
          : _PhotoGrid(photos: photos),
    );
  }
}

// ConsumerStatefulWidget — quando precisa de ciclo de vida (TextEditingController)
class GallerySearchBar extends ConsumerStatefulWidget {
  const GallerySearchBar({super.key});
  @override
  ConsumerState<GallerySearchBar> createState() => _GallerySearchBarState();
}

class _GallerySearchBarState extends ConsumerState<GallerySearchBar> {
  late final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _ctrl,
      onChanged: (v) =>
          // ref.read → acessa SEM observar — use em handlers/callbacks
          ref.read(photoFilterProvider.notifier).setQuery(v),
    );
  }
}

// ── Widgets privados deste arquivo ────────────────────────────────

class _PhotoGrid extends StatelessWidget {
  final List<Photo> photos;
  const _PhotoGrid({required this.photos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
      itemCount: photos.length,
      itemBuilder: (_, i) => PhotoTile(photo: photos[i]),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) => const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.photo_library_outlined, size: 80, color: Colors.grey),
      SizedBox(height: 16),
      Text('Galeria vazia',
          style: TextStyle(color: Colors.white, fontSize: 20,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Toque na câmera para começar',
          style: TextStyle(color: Colors.grey)),
    ],
  );
}

class _ErrorView extends StatelessWidget {
  final String mensagem;
  final VoidCallback onRetry;
  const _ErrorView({required this.mensagem, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 48),
        const SizedBox(height: 12),
        Text(mensagem,
            style: const TextStyle(color: Colors.white70),
            textAlign: TextAlign.center),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Tentar novamente'),
        ),
      ]),
    );
  }
}