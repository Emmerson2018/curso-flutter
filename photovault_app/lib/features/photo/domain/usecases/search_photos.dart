import '../entities/photo.dart';
import '../repositories/photo_repository.dart';

class SearchPhotos {
  final PhotoRepository _repo;
  const SearchPhotos(this._repo);

  Future<List<Photo>> call(String query) =>
      _repo.searchRemotePhotos(query);
}