// ============================================================
// AULA 10 — Acessibilidade: Text-to-Speech
// Serviço singleton que encapsula flutter_tts.
// Inicializado com voz pt-BR e velocidade natural (0.45).
// ============================================================

import 'package:flutter_tts/flutter_tts.dart';

import '../../domain/models/diorama_analysis.dart';
import '../../domain/models/estagio_embrionario.dart';

class TtsService {
  TtsService._internal();

  // Singleton — um único FlutterTts para todo o app
  static final TtsService instancia = TtsService._internal();

  final FlutterTts _tts = FlutterTts();
  bool _inicializado = false;

  // ----------------------------------------------------------
  // Inicialização
  // ----------------------------------------------------------
  Future<void> _garantirInicializado() async {
    if (_inicializado) return;
    await _tts.setLanguage('pt-BR');
    await _tts.setSpeechRate(0.45);  // velocidade natural para pt-BR
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _inicializado = true;
  }

  // ----------------------------------------------------------
  // API pública
  // ----------------------------------------------------------

  /// Fala qualquer texto. Para a fala anterior antes de iniciar.
  Future<void> falar(String texto) async {
    if (texto.trim().isEmpty) return;
    await _garantirInicializado();
    await _tts.stop();
    await _tts.speak(texto);
  }

  Future<void> parar() async => _tts.stop();

  // ----------------------------------------------------------
  // Métodos específicos do domínio (Aula 10)
  // ----------------------------------------------------------

  /// Narra a análise completa de um diorama.
  Future<void> narrarAnalise(DioramaAnalysis analise) async {
    await falar(analise.audioDescricao);
  }

  /// Narra um estágio embrionário individual.
  Future<void> narrarEstagio(EstagioEmbrionario estagio) async {
    await falar(estagio.gerarAudioDescricao());
  }

  /// Narra o texto de erro para usuários com audiodescrição ativa.
  Future<void> narrarErro(String mensagem) async {
    await falar('Erro: $mensagem. Tente novamente.');
  }
}
