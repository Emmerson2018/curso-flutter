import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/photo_providers.dart';
import '../../../../features/photo/data/models/unsplash_photo.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _ctrl        = TextEditingController();
  final _scrollCtrl  = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Carregar fotos em destaque ao abrir a tela
    _scrollCtrl.addListener(_onScroll);
  }

  void _onScroll() {
    // Infinite scroll: carrega mais ao chegar perto do fim
    if (_scrollCtrl.position.pixels >= _scrollCtrl.position.maxScrollExtent - 400) {
      ref.read(unsplashSearchProvider.notifier).loadMore();
    }
  }

  void _onChanged(String v) {
    _debounce?.cancel();
    // Debounce: espera 600ms de inatividade antes de buscar
    _debounce = Timer(const Duration(milliseconds: 600), () {
      ref.read(unsplashSearchProvider.notifier).search(v);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose(); _scrollCtrl.dispose(); _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photosAsync = ref.watch(unsplashSearchProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _ctrl,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Buscar fotos no Unsplash...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: _onChanged,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: photosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error:   (e, _) => Center(child: Text('Erro: $e', style: const TextStyle(color: Colors.red))),
        data:    (photos) => GridView.builder(
          controller: _scrollCtrl,
          padding: const EdgeInsets.all(2),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
          itemCount: photos.length,
          itemBuilder: (_, i) => _SearchTile(photo: photos[i]),
        ),
      ),
    );
  }
}

class _SearchTile extends ConsumerWidget {
  final UnsplashPhoto photo;
  const _SearchTile({required this.photo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(fit: StackFit.expand, children: [
      CachedNetworkImage(
        imageUrl: photo.urls.thumb,
        fit: BoxFit.cover,
        placeholder: (_, _) => Container(color: Colors.grey[850]),
        errorWidget: (_, _, _) => const Icon(Icons.broken_image, color: Colors.grey),
      ),
      Positioned(bottom: 4, right: 4,
        child: GestureDetector(
          onTap: () async {
            await ref.read(unsplashSearchProvider.notifier).saveToGallery(photo);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Foto salva na galeria!'), backgroundColor: Colors.green));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(6)),
            child: const Icon(Icons.add, color: Colors.white, size: 18),
          ),
        )),
    ]);
  }
}