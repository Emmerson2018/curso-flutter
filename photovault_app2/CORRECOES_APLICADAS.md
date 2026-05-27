# Correções aplicadas no projeto PhotoVault

## Diagnóstico principal

Os erros informados indicavam três problemas principais:

1. Os arquivos gerados pelo `build_runner` não estavam presentes ou estavam desatualizados:
   - `*.g.dart`
   - `*.freezed.dart`

2. As classes com `@freezed` estavam no formato antigo:
   - `class Photo with _$Photo`
   - Com `freezed` 3.x, o formato recomendado é:
   - `abstract class Photo with _$Photo`

3. Alguns providers usavam tipos gerados específicos, como:
   - `DioClientRef`
   - `TtsServiceRef`
   - `AppDatabaseRef`
   - `PhotoRepositoryRef`
   - `PhotoGalleryStreamRef`
   - `FilteredPhotosRef`

   Esses tipos dependem da geração de código. Para reduzir erros no editor e alinhar ao Riverpod mais recente, foram trocados por `Ref`.

## Arquivos corrigidos

- `lib/core/network/dio_client.dart`
- `lib/core/tts/tts_service.dart`
- `lib/database/app_database.dart`
- `lib/features/photo/domain/entities/photo.dart`
- `lib/features/photo/data/models/photo_model.dart`
- `lib/features/photo/data/models/unsplash_photo.dart`
- `lib/features/photo/data/datasources/photo_remote_ds.dart`
- `lib/features/photo/data/datasources/photo_local_ds.dart`
- `lib/features/photo/presentation/providers/photo_providers.dart`

## Comandos obrigatórios depois de substituir os arquivos

Execute na raiz do projeto:

```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Se preferir usar Flutter:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Observação importante

O projeto usa Drift, Freezed e Riverpod Generator. Portanto, sem rodar o `build_runner`, os arquivos gerados continuarão ausentes e o editor continuará mostrando erros.
