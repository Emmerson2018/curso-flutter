import '../entities/photo.dart';
import '../repositories/photo_repository.dart';

class SavePhoto {
  final PhotoRepository _repo;
  const SavePhoto(this._repo);

  Future<void> call(Photo photo) => _repo.savePhoto(photo);
}