// ============================================================
// AULA 2 — Modelagem Orientada a Objetos
// AULA 3 — Coleções e processamento funcional de JSON
// AULA 4 — Async: este objeto é o resultado final do Future<>
//           retornado pelo IAService.
// ============================================================

import 'especie.dart';

class DioramaAnalysis {
  DioramaAnalysis({
    required this.idAnalise,
    required this.dataAnalise,
    required this.especiesDetectadas,
    required this.interacoesEcologicas,
    required this.confiancaIA,
    this.urlVideoLibras,
  }) : audioDescricao = _gerarAudioDescricao(especiesDetectadas, interacoesEcologicas);

  /// Constrói a partir do JSON retornado pela API de IA (Gemini / GPT-4o).
  factory DioramaAnalysis.fromJson(Map<String, dynamic> json) {
    // Aula 3: List.map() + fromJson() — padrão ensinado em coleções
    final lista = json['especies'] as List<dynamic>? ?? [];
    final especies = lista
        .map((e) => Especie.fromJson(e as Map<String, dynamic>))
        .toList();

    return DioramaAnalysis(
      idAnalise: DateTime.now().millisecondsSinceEpoch.toString(),
      dataAnalise: DateTime.now(),
      especiesDetectadas: especies,
      interacoesEcologicas:
          json['interacoes'] as String? ?? 'Sem interações identificadas.',
      confiancaIA: (json['confianca'] as num?)?.toDouble() ?? 0.0,
      urlVideoLibras: json['url_video_libras'] as String?,
    );
  }

  final String idAnalise;
  final DateTime dataAnalise;
  final List<Especie> especiesDetectadas;
  final String interacoesEcologicas;

  /// 0.0 – 1.0  (exibir como porcentagem na UI)
  final double confiancaIA;

  /// URL do vídeo de intérprete de Libras — null se não disponível.
  final String? urlVideoLibras;

  /// Audiodescrição completa gerada automaticamente no construtor.
  final String audioDescricao;

  bool get temLibras => urlVideoLibras != null;

  // ----------------------------------------------------------
  // Geração de audiodescrição (Aula 10)
  // ----------------------------------------------------------
  static String _gerarAudioDescricao(
    List<Especie> especies,
    String interacoes,
  ) {
    if (especies.isEmpty) return 'Nenhuma espécie identificada neste diorama.';

    // Aula 3: map() + join() para gerar texto a partir de lista
    final descEspecies = especies.map((e) => e.gerarAudioDescricao()).join(' ');
    return 'Diorama analisado. '
        '${especies.length} espécie(s) identificada(s). '
        '$descEspecies '
        'Interações ecológicas: $interacoes';
  }

  // ----------------------------------------------------------
  // Serialização (para HistoryService)
  // ----------------------------------------------------------
  Map<String, dynamic> toJson() => {
        'id': idAnalise,
        'data': dataAnalise.toIso8601String(),
        'especies': especiesDetectadas.map((e) => e.toJson()).toList(),
        'interacoes': interacoesEcologicas,
        'confianca': confiancaIA,
        'url_video_libras': urlVideoLibras,
        // audioDescricao é gerado automaticamente, não precisa persistir
      };

  factory DioramaAnalysis.fromJsonStorage(Map<String, dynamic> json) {
    final lista = json['especies'] as List<dynamic>? ?? [];
    final especies =
        lista.map((e) => Especie.fromJson(e as Map<String, dynamic>)).toList();
    return DioramaAnalysis(
      idAnalise: json['id'] as String,
      dataAnalise: DateTime.parse(json['data'] as String),
      especiesDetectadas: especies,
      interacoesEcologicas: json['interacoes'] as String,
      confiancaIA: (json['confianca'] as num).toDouble(),
      urlVideoLibras: json['url_video_libras'] as String?,
    );
  }
}
