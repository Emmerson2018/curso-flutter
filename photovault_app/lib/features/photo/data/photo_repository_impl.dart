import 'package:drift/drift.dart' show Value;
import '../../../database/app_database.dart';
import 'datasources/photo_local_ds.dart';
import 'datasources/photo_remote_ds.dart';
import 'models/unsplash_photo.dart';
import '../domain/entities/photo.dart';
import '../domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoLocalDataSource  _local;
  final PhotoRemoteDataSource _remote;

  PhotoRepositoryImpl({
    required PhotoLocalDataSource  localDs,
    required PhotoRemoteDataSource remoteDs,
  })  : _local  = localDs,
        _remote = remoteDs;

  @override
  Stream<List<Photo>> watchLocalPhotos() =>
      _local.watchAll().map((rows) => rows.map(_toEntity).toList());

  @override
  Future<List<Photo>> getLocalPhotos() async =>
      (await _local.getAll()).map(_toEntity).toList();

  @override
  Future<Photo?> getPhotoById(String id) async {
    final row = await _local.getById(id);
    return row == null ? null : _toEntity(row);
  }

  @override
  Future<void> savePhoto(Photo p) => _local.insert(PhotosCompanion(
    id:               Value(p.id),
    localPath:        Value(p.localPath),
    createdAt:        Value(p.createdAt),
    caption:          Value(p.caption),
    audioDesc:        Value(p.audioDescription),
    remoteUrl:        Value(p.remoteUrl),
    photographerName: Value(p.photographerName),
  ));

  @override
  Future<void> updatePhotoMeta(String id,
      {String? caption, String? audioDescription, bool? isFavorite}) =>
    _local.update(PhotosCompanion(
      id:         Value(id),
      caption:    caption != null ? Value(caption) : const Value.absent(),
      audioDesc:  audioDescription != null ? Value(audioDescription) : const Value.absent(),
      isFavorite: isFavorite != null ? Value(isFavorite) : const Value.absent(),
    ));

  @override
  Future<void> deletePhoto(String id) => _local.delete(id);

  @override
  Future<List<Photo>> searchRemotePhotos(String query) async {
    final results = await _remote.searchPhotos(query);
    return results.map((m) => Photo(
      id: m.id, localPath: m.urls.regular, createdAt: DateTime.now(),
      remoteUrl: m.urls.regular, caption: m.description ?? m.altDescription,
      audioDescription: m.altDescription, photographerName: m.user.name,
    )).toList();
  }

  Photo _toEntity(PhotoRow r) => Photo(
    id:               r.id,
    localPath:        r.localPath,
    createdAt:        r.createdAt,
    caption:          r.caption,
    audioDescription: r.audioDesc,
    remoteUrl:        r.remoteUrl,
    photographerName: r.photographerName,
    isFavorite:       r.isFavorite,
  );
}
