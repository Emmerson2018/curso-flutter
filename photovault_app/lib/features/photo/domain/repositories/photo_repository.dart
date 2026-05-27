import '../entities/photo.dart';

// CONTRATO: define O QUE faz, não COMO
// A Data Layer implementa; o Domain nunca sabe qual banco ou API é usado
abstract class PhotoRepository {
  Stream<List<Photo>> watchLocalPhotos();          // stream reativo
  Future<List<Photo>> getLocalPhotos();
  Future<Photo?>         getPhotoById(String id);
  Future<void>          savePhoto(Photo photo);
  Future<void>          deletePhoto(String id);
  Future<void>          updatePhotoMeta(String id,
      {String? caption, String? audioDescription, bool? isFavorite});
  Future<List<Photo>> searchRemotePhotos(String query);
}