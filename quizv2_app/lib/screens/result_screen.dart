import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score, total;
  const ResultScreen({super.key, required this.score, required this.total});

  // Record com emoji, label e cor — switch expression Dart 3
  (String, String, Color) _feedback(ColorScheme s) {
    final pct = score / total;
    return switch (true) {
      _ when pct >= .9  => ('🏆', 'Excelente!',        s.primary),
      _ when pct >= .7  => ('⭐', 'Muito bom!',        s.tertiary),
      _ when pct >= .5  => ('👍', 'Bom trabalho!',      s.secondary),
      _                  => ('📚', 'Continue estudando!', s.error),
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (emoji, label, color) = _feedback(scheme);
    final pct = score / total;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(emoji, style: const TextStyle(fontSize: 72)),
              const SizedBox(height: 16),
              Text(label,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 24),
              // CircularProgressIndicator com ColorScheme — sem deprecated
              SizedBox(width: 140, height: 140,
                child: Stack(alignment: Alignment.center, children: [
                  SizedBox.expand(child: CircularProgressIndicator(
                    value: pct, strokeWidth: 10,
                    backgroundColor: scheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(color),
                  )),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Text('$score/$total',
                      style: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                    Text('acertos',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant, fontSize: 13)),
                  ]),
                ]),
              ),
              const SizedBox(height: 28),
              Text(
                'Você acertou ${(pct * 100).round()}% das perguntas.',
                style: TextStyle(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // pushAndRemoveUntil: zera a pilha e volta à WelcomeScreen
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52)),
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WelcomeScreen()),
                  (_) => false,
                ),
                icon: const Icon(Icons.replay),
                label: const Text('Jogar Novamente'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
