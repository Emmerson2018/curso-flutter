import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/photo_remote_ds.dart';
import '../../data/models/unsplash_photo.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _ctrl       = TextEditingController();
  final _scrollCtrl = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollCtrl.position.pixels >=
        _scrollCtrl.position.maxScrollExtent - 400) {
      ref.read(unsplashSearchProvider.notifier).loadMore();
    }
  }

  void _onChanged(String v) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      ref.read(unsplashSearchProvider.notifier).search(v);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    _debounce?.cancel();
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
          controller:  _ctrl,
          autofocus:   true,
          style:       const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration:  const InputDecoration(
            hintText:  'Buscar fotos no Unsplash...',
            hintStyle: TextStyle(color: Colors.white54),
            border:    InputBorder.none,
          ),
          onChanged: _onChanged,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: photosAsync.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.white)),
        error: (e, st) => Center(
            child: Text('Erro: $e',
                style: const TextStyle(color: Colors.red))),
        data: (photos) => GridView.builder(
          controller: _scrollCtrl,
          padding:    const EdgeInsets.all(2),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2),
          itemCount:   photos.length,
          itemBuilder: (ctx, i) => _SearchTile(photo: photos[i]),
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
        imageUrl:    photo.urls.thumb,
        fit:         BoxFit.cover,
        // Dart 3: não pode repetir _ em parâmetros do mesmo escopo
        placeholder: (ctx, url) =>
            Container(color: Colors.grey[850]),
        errorWidget: (ctx, url, err) =>
            const Icon(Icons.broken_image, color: Colors.grey),
      ),
      Positioned(
        bottom: 4, right: 4,
        child: GestureDetector(
          onTap: () async {
            await ref
                .read(unsplashSearchProvider.notifier)
                .saveToGallery(photo);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:         Text('Foto salva na galeria!'),
                backgroundColor: Colors.green));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color:        Colors.black54,
                borderRadius: BorderRadius.circular(6)),
            child: const Icon(Icons.add, color: Colors.white, size: 18),
          ),
        ),
      ),
    ]);
  }
}
