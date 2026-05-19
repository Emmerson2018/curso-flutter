class Question {
  final int          id;
  final String       text;
  final List<String> options;
  final int          correct;       // índice 0-3
  final String       explanation;
  final String       category;

  const Question({
    required this.id, required this.text,
    required this.options, required this.correct,
    this.explanation = '', this.category = 'Geral',
  });

  // factory fromJson: lê um Map vindo do JSON e cria a Question
  factory Question.fromJson(Map<String, dynamic> j) => Question(
    id:          j['id']          as int,
    text:        j['text']        as String,
    options:     List<String>.from(j['options']),
    correct:     j['correct']    as int,
    explanation: j['explanation'] as String? ?? '',
    category:    j['category']   as String? ?? 'Geral',
  );
}