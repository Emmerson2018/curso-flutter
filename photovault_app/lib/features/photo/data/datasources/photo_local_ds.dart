import 'package:drift/drift.dart';
import '../../../database/app_database.dart';

// Wrapper do DAO para a camada Data
// Isola a lógica de banco do restante da Data Layer
class PhotoLocalDataSource {
  final PhotoDao _dao;
  const PhotoLocalDataSource(this._dao);

  Stream<List<Photo>> watchAll()                          => _dao.watchAllPhotos();
  Future<List<Photo>> getAll()                            => _dao.getAllPhotos();
  Future<Photo?>         getById(String id)               => _dao.getById(id);
  Future<void>          insert(PhotosCompanion c)         => _dao.insertPhoto(c);
  Future<void>          update(PhotosCompanion c)         => _dao.updatePhoto(c);
  Future<void>          delete(String id)                => _dao.deletePhoto(id).then((_) {});
  Stream<List<Photo>> watchFavorites()                    => _dao.watchFavorites();
}