// ============================================================
// AULA 4 — Async/Await e tratamento de erros
// AULA 9 — Integração com API de IA (Gemini Vision / GPT-4o)
//
// IMPORTANTE: A chave de API é lida do arquivo .env via
// flutter_dotenv — NUNCA coloque a chave diretamente no código!
// ============================================================

import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../domain/models/diorama_analysis.dart';
import '../../domain/models/resultado_api.dart';

class IAService {
  IAService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  void dispose() => _client.close();

  // ----------------------------------------------------------
  // Prompt enviado à IA (Aula 9)
  // ----------------------------------------------------------
  static const String promptSistema = '''
Você é um especialista em ecologia amazônica e educação ambiental inclusiva.
Analise este diorama e responda APENAS com um JSON válido, sem texto adicional:
{
  "especies": [
    {
      "nome": "nome popular em português",
      "nome_cientifico": "...",
      "bioma": "...",
      "posicao": "primeiro plano|centro|fundo|esquerda|direita",
      "ameacada": true,
      "descricao_acessivel": "frase para audiodescrição"
    }
  ],
  "interacoes": "texto descrevendo cadeia alimentar e interações ecológicas",
  "confianca": 0.0
}
''';

  // ----------------------------------------------------------
  // Análise por texto (mock + estrutura real) — Aula 3 e 4
  // ----------------------------------------------------------
  Future<ResultadoAPI<DioramaAnalysis>> analisarTexto(
      String descricao) async {
    try {
      // Mock didático — substitua por chamada real quando a API estiver disponível
      await Future<void>.delayed(const Duration(seconds: 2));
      final mockJson = _mockRespostaTexto(descricao);
      return ResultadoAPI.sucesso(DioramaAnalysis.fromJson(mockJson));
    } on TimeoutException {
      return ResultadoAPI.erro(
          'A análise demorou muito. Tente uma imagem menor ou mais nítida.');
    } catch (e) {
      return ResultadoAPI.erro('Erro inesperado: $e');
    }
  }

  // ----------------------------------------------------------
  // Análise por imagem — Aula 8 e 9
  // ----------------------------------------------------------
  Future<ResultadoAPI<DioramaAnalysis>> analisarImagem(
      File imagemFile) async {
    try {
      // Para usar a API real: descomente e configure a chave no .env
      // return await _chamarGemini(imagemFile);

      // Mock didático
      await Future<void>.delayed(const Duration(seconds: 3));
      final mockJson = _mockRespostaImagem();
      return ResultadoAPI.sucesso(DioramaAnalysis.fromJson(mockJson));
    } on TimeoutException {
      return ResultadoAPI.erro(
          'A análise demorou muito. Tente novamente em instantes.');
    } on SocketException {
      return ResultadoAPI.erro(
          'Sem conexão com a internet. Verifique sua rede.');
    } on FormatException catch (e) {
      return ResultadoAPI.erro('Erro ao processar resposta da IA: ${e.message}');
    } on HttpException catch (e) {
      return ResultadoAPI.erro(_traduzirErroHTTP(e.message));
    } catch (e) {
      return ResultadoAPI.erro('Erro inesperado: $e');
    }
  }

  // ----------------------------------------------------------
  // Stream de progresso — Aula 4 (async*)
  // Emite mensagens de status enquanto o processamento ocorre.
  // Usado com StreamBuilder na ImageAnalysisPage.
  // ----------------------------------------------------------
  Stream<String> analisarComProgresso(File imagemFile) async* {
    yield 'Lendo imagem do diorama...';
    await Future<void>.delayed(const Duration(milliseconds: 600));

    yield 'Preparando envio para a IA...';
    await Future<void>.delayed(const Duration(milliseconds: 500));

    yield 'Enviando para análise (pode levar até 15 segundos)...';
    await Future<void>.delayed(const Duration(seconds: 2));

    yield 'Identificando espécies amazônicas...';
    await Future<void>.delayed(const Duration(seconds: 1));

    yield 'Gerando audiodescrição acessível...';
    await Future<void>.delayed(const Duration(milliseconds: 800));

    yield 'Preparando conteúdo em Libras...';
    await Future<void>.delayed(const Duration(milliseconds: 600));

    yield 'Análise concluída!';
  }

  // ----------------------------------------------------------
  // Chamada real ao Google Gemini 1.5 Pro Vision (desabilitada)
  // Descomente e configure GEMINI_API_KEY no .env para ativar.
  // ----------------------------------------------------------
  // Future<ResultadoAPI<DioramaAnalysis>> _chamarGemini(File imagem) async {
  //   final bytes = await imagem.readAsBytes();
  //   final base64Img = base64Encode(bytes);
  //   final chave = dotenv.env['GEMINI_API_KEY']!;
  //
  //   final response = await _client.post(
  //     Uri.parse('https://generativelanguage.googleapis.com/v1beta/'
  //         'models/gemini-1.5-pro:generateContent?key=$chave'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'contents': [{
  //         'parts': [
  //           {'text': promptSistema},
  //           {'inline_data': {'mime_type': 'image/jpeg', 'data': base64Img}},
  //         ],
  //       }],
  //       'generationConfig': {'temperature': 0.2, 'maxOutputTokens': 2048},
  //     }),
  //   ).timeout(const Duration(seconds: 30));
  //
  //   if (response.statusCode != 200) {
  //     throw HttpException('${response.statusCode}');
  //   }
  //
  //   final json = jsonDecode(response.body) as Map<String, dynamic>;
  //   final texto = json['candidates'][0]['content']['parts'][0]['text'] as String;
  //   return ResultadoAPI.sucesso(DioramaAnalysis.fromJson(jsonDecode(texto)));
  // }

  // ----------------------------------------------------------
  // Tradução de erros HTTP (Aula 4)
  // ----------------------------------------------------------
  String _traduzirErroHTTP(String codigo) => switch (codigo) {
        '400' => 'Imagem inválida. Tente uma foto mais nítida do diorama.',
        '401' => 'Chave de API inválida. Verifique o arquivo .env.',
        '429' => 'Limite de requisições atingido. Aguarde 1 minuto.',
        '500' || '503' => 'Servidor da IA indisponível. Tente novamente.',
        _ => 'Erro na comunicação com a IA (código $codigo).',
      };

  // ----------------------------------------------------------
  // Mocks didáticos — substituir por chamada real
  // ----------------------------------------------------------
  Map<String, dynamic> _mockRespostaTexto(String descricao) => {
        'especies': [
          {
            'nome': 'Peixe-boi amazônico',
            'nome_cientifico': 'Trichechus inunguis',
            'bioma': 'Rio Amazonas',
            'posicao': 'centro',
            'ameacada': true,
            'descricao_acessivel':
                'Grande mamífero aquático no centro da cena.',
          },
          {
            'nome': 'Garça-branca-grande',
            'nome_cientifico': 'Ardea alba',
            'bioma': 'Várzea',
            'posicao': 'primeiro plano',
            'ameacada': false,
            'descricao_acessivel':
                'Ave de pernas longas à margem do rio.',
          },
          {
            'nome': 'Vitória-régia',
            'nome_cientifico': 'Victoria amazonica',
            'bioma': 'Igapó',
            'posicao': 'fundo',
            'ameacada': false,
            'descricao_acessivel':
                'Planta aquática de folhas circulares gigantes ao fundo.',
          },
        ],
        'interacoes':
            'O peixe-boi se alimenta de macrófitas aquáticas como a '
                'vitória-régia. A garça aguarda presas próxima à margem.',
        'confianca': 0.93,
      };

  Map<String, dynamic> _mockRespostaImagem() => {
        'especies': [
          {
            'nome': 'Onça-pintada',
            'nome_cientifico': 'Panthera onca',
            'bioma': 'Floresta Amazônica',
            'posicao': 'esquerda',
            'ameacada': true,
            'descricao_acessivel':
                'Maior felino das Américas à esquerda da cena.',
          },
          {
            'nome': 'Ariranha',
            'nome_cientifico': 'Pteronura brasiliensis',
            'bioma': 'Rios Amazônicos',
            'posicao': 'centro',
            'ameacada': true,
            'descricao_acessivel':
                'Lontra gigante no centro próxima à água.',
          },
          {
            'nome': 'Ararajuba',
            'nome_cientifico': 'Guaruba guarouba',
            'bioma': 'Floresta Amazônica',
            'posicao': 'fundo',
            'ameacada': true,
            'descricao_acessivel':
                'Papagaio amarelo-vivo pousado no galho ao fundo.',
          },
        ],
        'interacoes':
            'A onça-pintada é predadora de topo de cadeia. '
                'A ariranha compete com outras espécies por peixes. '
                'A ararajuba dispersa sementes pela floresta.',
        'confianca': 0.91,
      };
}
