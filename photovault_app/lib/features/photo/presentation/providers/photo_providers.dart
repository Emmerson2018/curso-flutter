import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../database/app_database.dart';
import '../../data/datasources/photo_local_ds.dart';
import '../../data/datasources/photo_remote_ds.dart';
import '../../data/photo_repository_impl.dart';
import '../../domain/entities/photo.dart';
import '../../domain/repositories/photo_repository.dart';
import '../../../../core/network/dio_client.dart';

part 'photo_providers.g.dart';

// ── 1. Banco de dados ─────────────────────────────────────────────
@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

// ── 2. Repositório com injeção de dependências ────────────────────
@Riverpod(keepAlive: true)
Future<PhotoRepository> photoRepository(PhotoRepositoryRef ref) async {
  final db     = ref.watch(appDatabaseProvider);
  final client = await ref.watch(dioClientProvider.future);
  return PhotoRepositoryImpl(
    localDs:  PhotoLocalDataSource(db.photoDao),
    remoteDs: PhotoRemoteDataSource(client.dio),
  );
}

// ── 3. Stream reativo da galeria ──────────────────────────────────
@riverpod
Stream<List<Photo>> photoGalleryStream(PhotoGalleryStreamRef ref) async* {
  final repo = await ref.watch(photoRepositoryProvider.future);
  yield* repo.watchLocalPhotos();
}

// ── 4. AsyncNotifier com CRUD ─────────────────────────────────────
@riverpod
class PhotoGallery extends _$PhotoGallery {
  @override
  Future<List<Photo>> build() async {
    final repo = await ref.watch(photoRepositoryProvider.future);
    return repo.getLocalPhotos();
  }

  Future<void> addPhoto(Photo photo) async {
    final current = state.valueOrNull ?? [];
    state = AsyncData([photo, ...current]);
    try {
      final repo = await ref.read(photoRepositoryProvider.future);
      await repo.savePhoto(photo);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }

  Future<void> updateCaption(String id, String caption) async {
    final repo = await ref.read(photoRepositoryProvider.future);
    await repo.updatePhotoMeta(id, caption: caption);
    ref.invalidateSelf();
  }

  Future<void> deletePhoto(String id) async {
    final repo = await ref.read(photoRepositoryProvider.future);
    await repo.deletePhoto(id);
    ref.invalidateSelf();
  }
}

// ── 5. Filtro síncrono ────────────────────────────────────────────
@riverpod
class PhotoFilter extends _$PhotoFilter {
  @override
  PhotoFilterState build() => PhotoFilterState.initial();
  void setQuery(String q)   => state = state.copyWith(searchQuery: q);
  void setSort(SortOrder o) => state = state.copyWith(sortOrder: o);
}

// ── 6. Provider derivado: galeria filtrada ────────────────────────
@riverpod
List<Photo> filteredPhotos(FilteredPhotosRef ref) {
  final photos = ref.watch(photoGalleryStreamProvider).valueOrNull ?? [];
  final filter = ref.watch(photoFilterProvider);
  return photos
    .where((p) => filter.searchQuery.isEmpty ||
        (p.caption ?? '').toLowerCase().contains(filter.searchQuery.toLowerCase()))
    .toList()
    ..sort((a, b) => filter.sortOrder == SortOrder.newest
        ? b.createdAt.compareTo(a.createdAt)
        : a.createdAt.compareTo(b.createdAt));
}
