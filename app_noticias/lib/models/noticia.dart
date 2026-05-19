class Noticia {
  final String  titulo;
  final String  descricao;
  final String  urlArtigo;
  final String? urlImagem;
  final String  fonte;
  final DateTime publicadaEm;

  const Noticia({
    required this.titulo,
    required this.descricao,
    required this.urlArtigo,
    this.urlImagem,
    required this.fonte,
    required this.publicadaEm,
  });

  // factory constructor: cria uma instância a partir de um Map (JSON)
  factory Noticia.fromJson(Map<String, dynamic> json) => Noticia(
    titulo:      json['title']       ?? 'Sem título',
    descricao:   json['description'] ?? 'Sem descrição',
    urlArtigo:   json['url']         ?? '',
    urlImagem:   json['urlToImage'],
    fonte:       json['source']?['name'] ?? 'Desconhecida',
    publicadaEm: DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
  );
}