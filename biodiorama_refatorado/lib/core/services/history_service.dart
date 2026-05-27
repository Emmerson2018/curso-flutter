// ============================================================
// AULA 7 — Persistência com SharedPreferences
// Histórico de análises usando DioramaAnalysis (não AnaliseIA).
// ============================================================

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/diorama_analysis.dart';

class HistoryService {
  static const _storageKey = 'biodiorama_historico';

  Future<void> salvar(DioramaAnalysis analise) async {
    final prefs = await SharedPreferences.getInstance();
    final atual = prefs.getStringList(_storageKey) ?? [];
    atual.insert(0, jsonEncode(analise.toJson()));
    // Mantém no máximo 20 entradas no histórico
    if (atual.length > 20) atual.removeRange(20, atual.length);
    await prefs.setStringList(_storageKey, atual);
  }

  Future<List<DioramaAnalysis>> carregarTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList(_storageKey) ?? [];
    return lista
        .map((e) => DioramaAnalysis.fromJsonStorage(
            jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Future<void> limpar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
