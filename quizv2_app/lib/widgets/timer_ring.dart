import 'package:flutter/material.dart';

// Widget puro — recebe apenas dados, sem lógica de timer
// O timer fica no QuizScreen, o visual fica aqui
class TimerRing extends StatelessWidget {
  final int seconds;
  final int total;    // total para calcular a fração restante

  const TimerRing({super.key, required this.seconds, this.total = 20});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fraction = seconds / total;

    // Cor muda conforme o tempo restante — switch expression Dart 3
    final ringColor = switch (true) {
      _ when seconds > 10 => scheme.primary,
      _ when seconds > 5  => const Color(0xFFD97706),   // âmbar
      _                   => scheme.error,
    };

    return SizedBox(
      width: 44, height: 44,
      child: Stack(alignment: Alignment.center, children: [
        SizedBox.expand(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: CircularProgressIndicator(
              value: fraction,
              strokeWidth: 4,
              // Color.withValues() — substituto moderno de withOpacity()
              backgroundColor: ringColor.withValues(alpha: .2),
              valueColor: AlwaysStoppedAnimation(ringColor),
            ),
          ),
        ),
        Text(
          '$seconds',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: ringColor,
          ),
        ),
      ]),
    );
  }
}