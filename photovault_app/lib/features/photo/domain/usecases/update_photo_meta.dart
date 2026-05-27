import '../repositories/photo_repository.dart';

class UpdatePhotoMeta {
  final PhotoRepository _repo;
  const UpdatePhotoMeta(this._repo);

  Future<void> call(String id, {
    String? caption,
    String? audioDescription,
    bool?   isFavorite,
  }) => _repo.updatePhotoMeta(id,
      caption: caption,
      audioDescription: audioDescription,
      isFavorite: isFavorite);
}