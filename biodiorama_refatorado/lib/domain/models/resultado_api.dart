// ============================================================
// AULA 3 — Generics
// Padrão ResultadoAPI<T> ensinado na apostila.
// Usado em TODA chamada de serviço: loading → sucesso → erro.
// A UI decide o que exibir com base no estado do objeto.
// ============================================================

/// Encapsula os três estados possíveis de uma chamada assíncrona.
/// T é o tipo do dado esperado (ex: DioramaAnalysis, List<EstagioEmbrionario>).
class ResultadoAPI<T> {
  const ResultadoAPI._({
    this.dados,
    this.mensagemErro,
    required this.carregando,
  });

  // Construtores factory — padrão ensinado na Aula 3
  factory ResultadoAPI.carregando() =>
      const ResultadoAPI._(carregando: true);

  factory ResultadoAPI.sucesso(T dados) =>
      ResultadoAPI._(dados: dados, carregando: false);

  factory ResultadoAPI.erro(String mensagem) =>
      ResultadoAPI._(mensagemErro: mensagem, carregando: false);

  final T? dados;
  final String? mensagemErro;
  final bool carregando;

  bool get temDados => dados != null;
  bool get temErro => mensagemErro != null;
  bool get vazio => !carregando && !temDados && !temErro;
}
