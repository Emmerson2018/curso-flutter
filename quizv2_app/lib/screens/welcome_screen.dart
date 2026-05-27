import 'package:flutter/material.dart';
import '../services/quiz_service.dart';
import 'quiz_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Icon(Icons.quiz_outlined,
                  size: 52, color: scheme.primary),
              ),
              const SizedBox(height: 28),
              Text('Quiz Flutter',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(
                'Teste seus conhecimentos sobre Flutter e Dart.\n10 perguntas, 20 segundos cada.',
                textAlign: TextAlign.center,
                style: TextStyle(color: scheme.onSurfaceVariant, height: 1.5),
              ),
              const Spacer(),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
                onPressed: () async {
                  // Mostra loading enquanto carrega o JSON
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(
                      child: CircularProgressIndicator()),
                  );
                  final questions =
                      await QuizService().loadQuestions(limit: 10);
                  if (context.mounted) {
                    Navigator.pop(context); // fecha loading
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => QuizScreen(questions: questions),
                    ));
                  }
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Iniciar Quiz'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}