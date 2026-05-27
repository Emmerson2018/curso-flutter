// ============================================================
// AULA 12 — Módulo Educacional: Desenvolvimento Embrionário
// Entidade com suporte nativo a acessibilidade (audiodescrição
// e roteiro para intérprete de Libras).
// ============================================================

class EstagioEmbrionario {
  const EstagioEmbrionario({
    required this.numero,
    required this.nome,
    required this.diasAposFerti,
    required this.descricao,
    required this.urlImagem,
    this.urlVideoLibras,
  });

  final int numero;

  /// Ex: "Blástula", "Gastrulação"
  final String nome;

  final int diasAposFerti;

  /// Descrição científica do estágio.
  final String descricao;

  /// Caminho do asset ou URL da imagem do estágio.
  final String urlImagem;

  /// URL do vídeo do intérprete de Libras (opcional).
  final String? urlVideoLibras;

  bool get temLibras => urlVideoLibras != null;

  // ----------------------------------------------------------
  // Acessibilidade
  // ----------------------------------------------------------

  /// Narração TTS completa do estágio — Aula 10.
  String gerarAudioDescricao() =>
      'Estágio $numero: $nome. '
      'Ocorre por volta do dia $diasAposFerti após a fertilização. '
      '$descricao';

  /// Texto simplificado para o intérprete de Libras — Aula 11.
  String gerarDescricaoLibras() =>
      'ESTÁGIO $numero | NOME: $nome | DIA: $diasAposFerti | $descricao';

  /// Rótulo Semantics para leitores de tela — Aula 10.
  String gerarTextoLeitorDeTela() =>
      'Estágio $numero de desenvolvimento embrionário: $nome.';
}

// ----------------------------------------------------------
// Dados dos 8 estágios humanos — Aula 12
// ----------------------------------------------------------
final List<EstagioEmbrionario> estagiosHumanos = [
  const EstagioEmbrionario(
    numero: 1,
    nome: 'Fecundação / Zigoto',
    diasAposFerti: 0,
    descricao:
        'União do espermatozoide com o óvulo. '
        'Formação do zigoto com 46 cromossomos (23 pares).',
    urlImagem: 'assets/images/embrio_01_zigoto.png',
  ),
  const EstagioEmbrionario(
    numero: 2,
    nome: 'Clivagem',
    diasAposFerti: 1,
    descricao:
        'O zigoto inicia divisões mitóticas sem crescimento celular. '
        'As células resultantes são chamadas blastômeros.',
    urlImagem: 'assets/images/embrio_02_clivagem.png',
  ),
  const EstagioEmbrionario(
    numero: 3,
    nome: 'Mórula',
    diasAposFerti: 3,
    descricao:
        'Aproximadamente 16 blastômeros formam uma massa sólida '
        'com aparência de amora.',
    urlImagem: 'assets/images/embrio_03_morula.png',
  ),
  const EstagioEmbrionario(
    numero: 4,
    nome: 'Blástula',
    diasAposFerti: 5,
    descricao:
        'Forma-se uma cavidade interna chamada blastocele. '
        'O embrião chega ao útero neste estágio.',
    urlImagem: 'assets/images/embrio_04_blastula.png',
  ),
  const EstagioEmbrionario(
    numero: 5,
    nome: 'Implantação',
    diasAposFerti: 7,
    descricao:
        'O blastocisto se fixa na parede uterina (endométrio). '
        'É o início oficial da gestação.',
    urlImagem: 'assets/images/embrio_05_implantacao.png',
  ),
  const EstagioEmbrionario(
    numero: 6,
    nome: 'Gastrulação',
    diasAposFerti: 14,
    descricao:
        'Formação das três camadas germinativas: '
        'ectoderma, mesoderma e endoderma.',
    urlImagem: 'assets/images/embrio_06_gastrula.png',
  ),
  const EstagioEmbrionario(
    numero: 7,
    nome: 'Neurulação',
    diasAposFerti: 18,
    descricao:
        'Formação do tubo neural a partir do ectoderma. '
        'Origem do sistema nervoso central.',
    urlImagem: 'assets/images/embrio_07_neurula.png',
  ),
  const EstagioEmbrionario(
    numero: 8,
    nome: 'Organogênese',
    diasAposFerti: 21,
    descricao:
        'Formação dos órgãos principais: coração, fígado, pulmões e membros. '
        'O coração já bate neste estágio.',
    urlImagem: 'assets/images/embrio_08_organogenese.png',
  ),
];
