# Correções restantes aplicadas no BioDiorama

## 1. `app_theme.dart`

Erro corrigido:

```text
The argument type 'CardTheme' can't be assigned to the parameter type 'CardThemeData?'
```

Correção aplicada:

```dart
cardTheme: CardThemeData(...)
```

Motivo: nas versões mais recentes do Flutter/Material 3, o parâmetro `cardTheme` do `ThemeData` espera `CardThemeData?`, não `CardTheme`.

## 2. `ia_service.dart`

Correções aplicadas:

- mantido `import 'dart:async';` para permitir `TimeoutException`;
- removido o bloco duplicado de `on SocketException`;
- adicionada captura de `TimeoutException` na análise por imagem;
- criado método `dispose()` para fechar o `http.Client`;
- renomeado o prompt privado `_prompt` para `promptSistema`, evitando alerta de campo privado não utilizado e preservando o texto para futura integração real com IA.

## 3. `withOpacity`

Todos os usos de:

```dart
.withOpacity(valor)
```

foram substituídos por:

```dart
.withValues(alpha: valor)
```

Motivo: nas versões recentes do Flutter, `withOpacity` aparece como depreciado, e o próprio analisador recomenda `withValues(alpha: ...)`.

## Comandos recomendados

Execute na raiz do projeto:

```bash
flutter clean
flutter pub get
dart fix --apply
flutter analyze
flutter test
flutter run
```

Se houver erro de cache do Android/Gradle, execute também:

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

No Windows PowerShell, o equivalente é:

```powershell
cd android
.\gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```
