import 'dart:convert';   // para json

// Enum: conjunto fixo e nomeado de valores possíveis
// Muito melhor do que usar strings soltas como 'pessoal', 'trabalho'
enum Categoria { pessoal, trabalho, estudos, saude }

// Extensão: adiciona métodos a tipos existentes sem herança
extension CategoriaInfo on Categoria {
  String get nome => switch (this) {
    Categoria.pessoal  => 'Pessoal',
    Categoria.trabalho => 'Trabalho',
    Categoria.estudos  => 'Estudos',
    Categoria.saude    => 'Saúde',
  };

  String get emoji => switch (this) {
    Categoria.pessoal  => '👤',
    Categoria.trabalho => '💼',
    Categoria.estudos  => '📚',
    Categoria.saude    => '❤️',
  };
}

class Tarefa {
  final String    id;
  final String    titulo;
  final Categoria categoria;
  final bool      concluida;
  final DateTime  criadaEm;

  const Tarefa({
    required this.id,
    required this.titulo,
    required this.categoria,
    this.concluida = false,
    required this.criadaEm,
  });

  // copyWith: cria uma cópia com alguns campos alterados
  // Padrão imutável — não modificamos o objeto, criamos um novo
  Tarefa copyWith({bool? concluida}) {
    return Tarefa(
      id:        id,
      titulo:    titulo,
      categoria: categoria,
      criadaEm:  criadaEm,
      concluida: concluida ?? this.concluida,
    );
  }

  // Serialização: converte para Map para guardar no SharedPreferences
  Map<String, dynamic> toJson() => {
    'id':        id,
    'titulo':    titulo,
    'categoria': categoria.index,   // enum → número
    'concluida': concluida,
    'criadaEm':  criadaEm.toIso8601String(),
  };

  // Desserialização: recria a tarefa a partir do Map salvo
  factory Tarefa.fromJson(Map<String, dynamic> json) => Tarefa(
    id:        json['id'],
    titulo:    json['titulo'],
    categoria: Categoria.values[json['categoria']],
    concluida: json['concluida'],
    criadaEm:  DateTime.parse(json['criadaEm']),
  );

  // Métodos utilitários para serializar uma lista inteira
  static String listaParaJson(List<Tarefa> lista) =>
    jsonEncode(lista.map((t) => t.toJson()).toList());

  static List<Tarefa> listaDeJson(String json) =>
    (jsonDecode(json) as List)
        .map((j) => Tarefa.fromJson(j))
        .toList();
}