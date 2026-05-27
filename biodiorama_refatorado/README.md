# BioDiorama IA — Projeto Refatorado

App educacional acessível com IA para análise de dioramas amazônicos.
Desenvolvido no **IFAM** como projeto do curso de Flutter e Dart.

## Estrutura do Projeto

```
lib/
├── main.dart                      ← Aula 7: MultiProvider + carregarPreferencias()
├── app/
│   └── app.dart                   ← Aula 7: MaterialApp.router + tema dinâmico
├── core/
│   ├── providers/
│   │   └── acessibilidade_provider.dart   ← Aula 7: ChangeNotifier + SharedPrefs
│   ├── router/
│   │   └── app_router.dart                ← Aula 7: go_router declarativo
│   ├── services/
│   │   ├── ia_service.dart                ← Aulas 4 e 9: Future + Stream + mocks
│   │   ├── tts_service.dart               ← Aula 10: singleton TTS pt-BR
│   │   └── history_service.dart           ← Aula 7: persistência de análises
│   └── theme/
│       └── app_theme.dart                 ← Aula 6: ThemeData claro + alto contraste
├── domain/
│   └── models/
│       ├── especie.dart                   ← Aula 2: entidade com fromJson/toJson
│       ├── diorama_analysis.dart          ← Aula 2: modelo principal da IA
│       ├── resultado_api.dart             ← Aula 3: genérico ResultadoAPI<T>
│       └── estagio_embrionario.dart       ← Aula 12: dados dos 8 estágios
├── features/
│   ├── home/home_page.dart                ← Aula 5: tela principal
│   ├── prompt_analysis/                   ← Aula 6: formulário + validação
│   ├── image_analysis/                    ← Aula 8: câmera + Stream de progresso
│   ├── result/result_page.dart            ← Aula 9: resultado com audiodescrição
│   ├── libras/libras_page.dart            ← Aula 11: player com fallback de texto
│   ├── embriologia/embriologia_page.dart  ← Aula 12: PageView + TTS automático
│   ├── history/history_page.dart          ← Aula 7: FutureBuilder + DioramaAnalysis
│   ├── accessibility_settings/            ← Aula 7: switches + slider de fonte
│   └── about/about_page.dart
└── shared/
    └── widgets/
        ├── especie_card.dart              ← Aula 6: MergeSemantics + chips
        ├── acessibilidade_bar.dart        ← Aula 7: barra reativa ao Provider
        └── app_drawer.dart               ← Aula 7: navegação go_router
```

## Configurando a chave de API (Aula 4)

1. Crie um arquivo `.env` na raiz do projeto:
```
GEMINI_API_KEY=AIza...
OPENAI_API_KEY=sk-...
```
2. Adicione `.env` ao `.gitignore` — **nunca versione chaves de API!**
3. Em `ia_service.dart`, descomente o método `_chamarGemini()` e remova o mock.

## Dependências (pubspec.yaml)

| Pacote | Versão | Aula |
|--------|--------|------|
| provider | ^6.1.2 | 7 |
| go_router | ^14.2.0 | 7 |
| shared_preferences | ^2.2.3 | 7 |
| http | ^1.2.2 | 4 e 9 |
| flutter_dotenv | ^5.1.0 | 4 |
| image_picker | ^1.1.2 | 8 |
| flutter_tts | ^4.0.2 | 10 |
| video_player | ^2.9.1 | 11 |

## Pré-requisitos

```bash
flutter pub get
flutter run
```

## Executar testes

```bash
flutter test
dart analyze
```

---
IFAM — Instituto Federal do Amazonas | Curso de Flutter e Dart
