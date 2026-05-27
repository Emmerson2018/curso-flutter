import '../entities/photo.dart';
import '../repositories/photo_repository.dart';

// Retorna um Stream reativo — a galeria atualiza sem polling
class GetLocalPhotos {
  final PhotoRepository _repo;
  const GetLocalPhotos(this._repo);

  Stream<List<Photo>> call() => _repo.watchLocalPhotos();
}