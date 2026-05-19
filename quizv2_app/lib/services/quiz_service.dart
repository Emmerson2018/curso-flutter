import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question.dart';

class QuizService {
  // Carrega as perguntas do arquivo JSON em assets/
  Future<List<Question>> loadQuestions({int limit = 10}) async {
    // rootBundle.loadString lê um arquivo da pasta assets
    final raw  = await rootBundle.loadString('assets/questions.json');
    final list = jsonDecode(raw) as List;
    final all  = list.map((j) => Question.fromJson(j)).toList();

    // Embaralha para cada sessão ser diferente
    all.shuffle();
    return all.take(limit).toList();
  }

  // Filtra por categoria (útil para futuros modos de quiz)
  Future<List<Question>> loadByCategory(String cat) async {
    final all = await loadQuestions(limit: 9999);
    return all.where((q) => q.category == cat).toList();
  }
}