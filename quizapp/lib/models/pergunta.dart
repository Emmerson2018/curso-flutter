class Pergunta {
  final String       texto;
  final List<String> alternativas;
  final int          respostaCorreta;   // índice 0–3
  final String       explicacao;

  const Pergunta({
    required this.texto,
    required this.alternativas,
    required this.respostaCorreta,
    this.explicacao = '',
  });
}

// Banco de perguntas — em um app real viria de uma API
const List<Pergunta> bancoPerguntasFlutter = [
  Pergunta(
    texto: 'O que é um Widget no Flutter?',
    alternativas: [
      'Um tipo de banco de dados',
      'A unidade básica de interface — tudo é widget',
      'Um arquivo de configuração',
      'Uma linguagem de programação',
    ],
    respostaCorreta: 1,
    explicacao: 'No Flutter, TUDO é um Widget: texto, botões, layouts, animações.',
  ),
  Pergunta(
    texto: 'Qual método você usa para atualizar a UI num StatefulWidget?',
    alternativas: ['updateUI()', 'refresh()', 'setState()', 'rebuild()'],
    respostaCorreta: 2,
    explicacao: 'setState() notifica o Flutter que o estado mudou e redesenha o widget.',
  ),
  Pergunta(
    texto: 'Qual widget empilha filhos VERTICALMENTE?',
    alternativas: ['Row', 'Stack', 'Wrap', 'Column'],
    respostaCorreta: 3,
    explicacao: 'Column empilha verticalmente. Row empilha horizontalmente.',
  ),
  Pergunta(
    texto: 'O que o Expanded faz dentro de uma Row ou Column?',
    alternativas: [
      'Aumenta o tamanho da fonte',
      'Faz o filho ocupar todo o espaço disponível',
      'Adiciona padding automático',
      'Cria uma animação de expansão',
    ],
    respostaCorreta: 1,
    explicacao: 'Expanded faz o filho preencher todo o espaço restante no eixo principal.',
  ),
  Pergunta(
    texto: 'Qual linguagem de programação o Flutter usa?',
    alternativas: ['JavaScript', 'Kotlin', 'Dart', 'Swift'],
    respostaCorreta: 2,
    explicacao: 'Flutter usa Dart, linguagem criada pelo Google especialmente para UIs rápidas.',
  ),
  Pergunta(
    texto: 'O que é Hot Reload no Flutter?',
    alternativas: [
      'Recompila o app do zero',
      'Reinicia o emulador',
      'Injeta mudanças de código sem perder o estado',
      'Atualiza as dependências',
    ],
    respostaCorreta: 2,
    explicacao: 'Hot Reload injeta código novo sem reiniciar, mantendo o estado da UI.',
  ),
  Pergunta(
    texto: 'Qual widget lista itens de forma eficiente (lazy)?',
    alternativas: ['Column', 'ListView.builder', 'SingleChildScrollView', 'Stack'],
    respostaCorreta: 1,
    explicacao: 'ListView.builder renderiza apenas os itens visíveis, ideal para listas longas.',
  ),
  Pergunta(
    texto: 'Como você adiciona espaço INTERNO a um widget?',
    alternativas: ['Margin', 'SizedBox', 'Padding', 'Spacer'],
    respostaCorreta: 2,
    explicacao: 'Padding adiciona espaço interno. Margin é externo (via Container). SizedBox cria espaço fixo.',
  ),
  Pergunta(
    texto: 'O que é o pubspec.yaml?',
    alternativas: [
      'O arquivo principal do app',
      'A configuração do banco de dados',
      'Gerenciador de dependências e assets',
      'O arquivo de internacionalização',
    ],
    respostaCorreta: 2,
    explicacao: 'pubspec.yaml declara dependências, assets (imagens, fontes) e metadados do app.',
  ),
  Pergunta(
    texto: 'Qual método do ciclo de vida é chamado UMA vez ao criar o widget?',
    alternativas: ['build()', 'dispose()', 'update()', 'initState()'],
    respostaCorreta: 3,
    explicacao: 'initState() roda uma vez na criação. build() roda toda vez que o estado muda.',
  ),
];