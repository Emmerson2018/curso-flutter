# Correção do projeto Biodiorama Refatorado

## Diagnóstico

Os erros informados no arquivo `lib/core/services/ia_service.dart` indicam:

1. `TimeoutException` não foi reconhecido porque falta o import:

```dart
import 'dart:async';
```

2. `dart:convert` aparece como import não utilizado.

3. O campo `_client` aparece como não utilizado. Quando existe um `http.Client` injetado, o ideal é usar `_client.get`, `_client.post`, etc., em vez de chamadas diretas como `http.post`.

4. O bloco `on TimeoutException` deve ficar antes de erros genéricos de rede, especialmente antes de tratamentos amplos.

## Como aplicar a correção automática

Copie o arquivo `corrigir_ia_service.py` para a raiz do projeto, ou seja, na mesma pasta onde está o `pubspec.yaml`.

Depois execute:

```bash
python corrigir_ia_service.py
```

Em seguida rode:

```bash
flutter clean
flutter pub get
dart fix --apply
flutter analyze
flutter test
flutter run
```

## Correção manual mínima

No início de `lib/core/services/ia_service.dart`, deixe os imports assim:

```dart
import 'dart:async';
import 'dart:io';
```

Remova:

```dart
import 'dart:convert';
```

No tratamento de exceções, prefira esta ordem:

```dart
} on TimeoutException catch (e) {
  throw Exception('Tempo limite excedido ao acessar o serviço de IA. Detalhes: $e');
} on SocketException catch (e) {
  throw Exception('Falha de conexão com a internet. Detalhes: $e');
} catch (e) {
  throw Exception('Erro inesperado ao acessar o serviço de IA. Detalhes: $e');
}
```

## Observação

O arquivo enviado está em formato `.rar` RAR5. O ambiente usado para gerar esta resposta conseguiu listar o arquivo, mas não possui `unrar`, `7z` ou `unar` instalados para extração completa. Por isso, esta entrega contém um patch seguro e focado nos erros informados.
