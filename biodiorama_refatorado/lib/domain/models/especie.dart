// ============================================================
// AULA 2 — Modelagem Orientada a Objetos
// Entidade central do domínio BioDiorama IA.
// Cada campo corresponde ao que a API de IA retorna no JSON.
// ============================================================

class Especie {
  const Especie({
    required this.nome,
    required this.nomeCientifico,
    required this.bioma,
    this.posicao,
    this.ameacadaExtincao = false,
    this.descricaoAcessivel,
  });

  /// Constrói uma Especie a partir do JSON retornado pela IA.
  /// Uso: Especie.fromJson(json["especies"][0])
  factory Especie.fromJson(Map<String, dynamic> json) {
    return Especie(
      nome: json['nome'] as String? ?? 'Espécie desconhecida',
      nomeCientifico: json['nome_cientifico'] as String? ?? '',
      bioma: json['bioma'] as String? ?? 'Amazônia',
      posicao: json['posicao'] as String?,
      ameacadaExtincao: json['ameacada'] as bool? ?? false,
      descricaoAcessivel: json['descricao_acessivel'] as String?,
    );
  }

  final String nome;
  final String nomeCientifico;
  final String bioma;

  /// Posição na cena: "centro", "primeiro plano", "fundo", etc.
  final String? posicao;

  final bool ameacadaExtincao;

  /// Texto usado diretamente pelo TTS e pelo intérprete de Libras.
  final String? descricaoAcessivel;

  // ----------------------------------------------------------
  // Serialização
  // ----------------------------------------------------------

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'nome_cientifico': nomeCientifico,
        'bioma': bioma,
        'posicao': posicao,
        'ameacada': ameacadaExtincao,
        'descricao_acessivel': descricaoAcessivel,
      };

  // ----------------------------------------------------------
  // Acessibilidade
  // ----------------------------------------------------------

  /// Gera audiodescrição no padrão: "Na [posição] da cena, um(a) [nome] ..."
  /// Usado pelo TtsService e pelo roteiro do intérprete de Libras.
  String gerarAudioDescricao() {
    final pos = posicao ?? 'na cena';
    final status =
        ameacadaExtincao ? ', espécie ameaçada de extinção,' : '';
    return 'Na $pos da cena, um(a) $nome$status pertencente ao bioma $bioma.';
  }

  /// Texto simplificado para o intérprete de Libras.
  String gerarDescricaoLibras() {
    final status = ameacadaExtincao ? 'AMEAÇADA' : 'ESTÁVEL';
    return 'ESPÉCIE: $nome | BIOMA: $bioma | STATUS: $status';
  }

  @override
  String toString() => '$nome ($nomeCientifico)';
}
