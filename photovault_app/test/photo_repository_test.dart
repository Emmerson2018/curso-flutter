import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photovault_app/features/photo/domain/entities/photo.dart';
import 'package:photovault_app/features/photo/domain/repositories/photo_repository.dart';

// Mock: sem banco real, sem HTTP, sem emulador.
class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  late MockPhotoRepository repo;

  setUp(() {
    repo = MockPhotoRepository();
  });

  group('PhotoRepository', () {
    test('getLocalPhotos retorna lista quando bem-sucedido', () async {
      final photos = [
        Photo(id: '1', localPath: '/1.jpg', createdAt: DateTime(2026, 1, 1)),
        Photo(id: '2', localPath: '/2.jpg', createdAt: DateTime(2026, 1, 2)),
      ];

      when(() => repo.getLocalPhotos()).thenAnswer((_) async => photos);

      final result = await repo.getLocalPhotos();

      expect(result, hasLength(2));
      expect(result.first.id, '1');
      verify(() => repo.getLocalPhotos()).called(1);
    });

    test('getLocalPhotos lança exceção quando o banco falha', () async {
      when(() => repo.getLocalPhotos()).thenThrow(Exception('Banco corrompido'));

      await expectLater(
        repo.getLocalPhotos(),
        throwsA(isA<Exception>()),
      );
      verify(() => repo.getLocalPhotos()).called(1);
    });

    test('updatePhotoMeta salva legenda corretamente', () async {
      when(() => repo.updatePhotoMeta('1', caption: 'Nova legenda'))
          .thenAnswer((_) async {});

      await repo.updatePhotoMeta('1', caption: 'Nova legenda');

      verify(() => repo.updatePhotoMeta('1', caption: 'Nova legenda'))
          .called(1);
    });
  });
}
