import 'dart:convert';

enum GoalCategory {
  saude('💪', 'Saúde'),
  carreira('💼', 'Carreira'),
  estudos('📚', 'Estudos'),
  financas('💰', 'Finanças'),
  pessoal('🎯', 'Pessoal');

  final String emoji;
  final String label;
  const GoalCategory(this.emoji, this.label);
}

// Classe imutável — nunca modificamos uma meta existente,
// sempre criamos uma nova cópia com copyWith()
class Goal {
  final String       id;
  final String       title;
  final GoalCategory category;
  final int          progress;  // 0 a 100
  final DateTime     deadline;
  final DateTime     createdAt;

  const Goal({
    required this.id,
    required this.title,
    required this.category,
    required this.deadline,
    required this.createdAt,
    this.progress = 0,
  });

  bool get isDone   => progress >= 100;
  bool get isActive => !isDone && deadline.isAfter(DateTime.now());
  bool get isOverdue => !isDone && deadline.isBefore(DateTime.now());

  // Cria cópia com campos alterados
  Goal copyWith({String? title, int? progress, DateTime? deadline}) => Goal(
    id:        id,
    title:     title     ?? this.title,
    category:  category,
    progress:  progress  ?? this.progress,
    deadline:  deadline  ?? this.deadline,
    createdAt: createdAt,
  );

  // Serialização para JSON (persistência no SharedPreferences)
  Map<String, dynamic> toJson() => {
    'id':        id,
    'title':     title,
    'category':  category.name,
    'progress':  progress,
    'deadline':  deadline.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
  };

  factory Goal.fromJson(Map<String, dynamic> j) => Goal(
    id:        j['id']       as String,
    title:     j['title']    as String,
    category:  GoalCategory.values.firstWhere(
      (c) => c.name == (j['category'] as String),
      orElse:  () => GoalCategory.pessoal,
    ),
    progress:  j['progress'] as int,
    deadline:  DateTime.parse(j['deadline']  as String),
    createdAt: DateTime.parse(j['createdAt'] as String),
  );

  // Converte lista de Goals para JSON string (para salvar no SharedPreferences)
  static String listToJson(List<Goal> goals) =>
      jsonEncode(goals.map((g) => g.toJson()).toList());

  static List<Goal> listFromJson(String raw) {
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((j) => Goal.fromJson(j as Map<String, dynamic>)).toList();
  }
}