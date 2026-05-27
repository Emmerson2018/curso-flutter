// ============================================================
// AULA 7 — Gerenciamento de Estado com Provider
// AcessibilidadeProvider: coração da inclusão do app.
// Persiste preferências com SharedPreferences para que o
// usuário não precise reconfigurar a cada acesso.
// ============================================================

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcessibilidadeProvider extends ChangeNotifier {
  // ----------------------------------------------------------
  // Estado privado
  // ----------------------------------------------------------
  bool _librasAtivado = false;
  bool _audioDescricaoAtivado = false;
  bool _altoContrasteAtivado = false;
  double _escalaFonte = 1.0;

  // ----------------------------------------------------------
  // Getters públicos (imutáveis para os widgets)
  // ----------------------------------------------------------
  bool get librasAtivado => _librasAtivado;
  bool get audioDescricaoAtivado => _audioDescricaoAtivado;
  bool get altoContrasteAtivado => _altoContrasteAtivado;
  double get escalaFonte => _escalaFonte;

  // ----------------------------------------------------------
  // Chaves do SharedPreferences
  // ----------------------------------------------------------
  static const _kLibras = 'pref_libras';
  static const _kAudioDesc = 'pref_audio_descricao';
  static const _kAltoContraste = 'pref_alto_contraste';
  static const _kEscalaFonte = 'pref_escala_fonte';

  // ----------------------------------------------------------
  // Carrega preferências salvas ao iniciar o app (Aula 7)
  // ----------------------------------------------------------
  Future<void> carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    _librasAtivado = prefs.getBool(_kLibras) ?? false;
    _audioDescricaoAtivado = prefs.getBool(_kAudioDesc) ?? false;
    _altoContrasteAtivado = prefs.getBool(_kAltoContraste) ?? false;
    _escalaFonte = prefs.getDouble(_kEscalaFonte) ?? 1.0;
    notifyListeners(); // reconstrói todos os widgets que escutam
  }

  // ----------------------------------------------------------
  // Ações do usuário — cada uma persiste e notifica
  // ----------------------------------------------------------

  void toggleLibras() {
    _librasAtivado = !_librasAtivado;
    notifyListeners();
    _salvar(_kLibras, _librasAtivado);
  }

  void toggleAudioDescricao() {
    _audioDescricaoAtivado = !_audioDescricaoAtivado;
    notifyListeners();
    _salvar(_kAudioDesc, _audioDescricaoAtivado);
  }

  void toggleAltoContraste() {
    _altoContrasteAtivado = !_altoContrasteAtivado;
    notifyListeners();
    _salvar(_kAltoContraste, _altoContrasteAtivado);
  }

  /// escala: 0.8 (menor) a 2.0 (maior) — Slider na TelaAcessibilidade.
  void ajustarEscalaFonte(double escala) {
    _escalaFonte = escala.clamp(0.8, 2.0);
    notifyListeners();
    _salvarDouble(_kEscalaFonte, _escalaFonte);
  }

  // ----------------------------------------------------------
  // Persistência interna
  // ----------------------------------------------------------
  Future<void> _salvar(String chave, bool valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(chave, valor);
  }

  Future<void> _salvarDouble(String chave, double valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(chave, valor);
  }
}
