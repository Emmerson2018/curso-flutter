import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_client.dart';
import '../models/unsplash_photo.dart';
import '../../domain/entities/photo.dart';
import '../../../photo/presentation/providers/photo_providers.dart';

part 'photo_remote_ds.g.dart';

class PhotoRemoteDataSource {
  final Dio _dio;
  PhotoRemoteDataSource(this._dio);

  Future<List<UnsplashPhoto>> searchPhotos(String query,
      {int page = 1, int perPage = 20}) async {
    final res = await _dio.get('/search/photos', queryParameters: {
      'query': query, 'page': page, 'per_page': perPage,
    });
    return UnsplashSearchResponse.fromJson(res.data).results;
  }

  Future<List<UnsplashPhoto>> getFeatured({int page = 1}) async {
    final res = await _dio.get('/photos', queryParameters: {
      'page': page, 'per_page': 20, 'order_by': 'editorial',
    });
    return (res.data as List)
        .map((j) => UnsplashPhoto.fromJson(j as Map<String, dynamic>))
        .toList();
  }
}

@Riverpod(keepAlive: true)
Future<PhotoRemoteDataSource> photoRemoteDs(Ref ref) async {
  final client = await ref.watch(dioClientProvider.future);
  return PhotoRemoteDataSource(client.dio);
}

@riverpod
class UnsplashSearch extends _$UnsplashSearch {
  int    _page    = 1;
  bool   _hasMore = true;
  String _query   = '';

  @override
  Future<List<UnsplashPhoto>> build() async {
    final ds = await ref.watch(photoRemoteDsProvider.future);
    return ds.getFeatured();
  }

  Future<void> search(String query) async {
    if (query.isEmpty) { ref.invalidateSelf(); return; }
    _query = query; _page = 1; _hasMore = true;
    state = const AsyncLoading();
    try {
      final ds = await ref.read(photoRemoteDsProvider.future);
      state = AsyncData(await ds.searchPhotos(query));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading || _query.isEmpty) return;
    _page++;
    final ds   = await ref.read(photoRemoteDsProvider.future);
    final more = await ds.searchPhotos(_query, page: _page);
    if (more.isEmpty) { _hasMore = false; return; }
    state = AsyncData([...(state.hasValue ? state.requireValue : <UnsplashPhoto>[]), ...more]);
  }

  Future<void> saveToGallery(UnsplashPhoto p) async {
    final photo = Photo(
      id:               p.id,
      localPath:        p.urls.regular,
      createdAt:        DateTime.now(),
      remoteUrl:        p.urls.regular,
      caption:          p.description ?? p.altDescription,
      audioDescription: p.altDescription,
      photographerName: p.user.name,
    );
    await ref.read(photoGalleryProvider.notifier).addPhoto(photo);
  }
}
