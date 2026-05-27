import 'package:flutter/material.dart';

// Widget stateless reutilizável — barra animada de progresso
class QuizProgressBar extends StatelessWidget {
  final int current;   // pergunta atual (0-based)
  final int total;

  const QuizProgressBar({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final value  = (current + 1) / total;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pergunta ${current + 1} de $total',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: scheme.onSurfaceVariant,
            ),
          ),
          Text(
            '${(value * 100).round()}%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: scheme.primary,
            ),
          ),
        ],
      ),
      const SizedBox(height: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value),
          duration: const Duration(milliseconds: 400),
          builder: (_, v, _) => LinearProgressIndicator(
            value: v,
            minHeight: 6,
            // Color.withValues() — correto no Flutter 3.27+
            backgroundColor: scheme.primary.withValues(alpha: .15),
            valueColor: AlwaysStoppedAnimation(scheme.primary),
          ),
        ),
      ),
    ]);
  }
}