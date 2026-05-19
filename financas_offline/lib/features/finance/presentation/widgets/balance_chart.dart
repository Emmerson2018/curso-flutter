import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../data/local/app_database.dart';

class BalanceChart extends StatelessWidget {
  final List<FinanceTransaction> transactions;

  const BalanceChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final ordered = [...transactions]
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 180,
          child: ordered.isEmpty
              ? const Center(child: Text('Sem dados para o gráfico.'))
              : CustomPaint(
                  painter: _BalanceChartPainter(
                    transactions: ordered,
                    lineColor: Theme.of(context).colorScheme.primary,
                    gridColor: Theme.of(context).colorScheme.outlineVariant,
                    textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  child: const SizedBox.expand(),
                ),
        ),
      ),
    );
  }
}

class _BalanceChartPainter extends CustomPainter {
  final List<FinanceTransaction> transactions;
  final Color lineColor;
  final Color gridColor;
  final Color textColor;

  const _BalanceChartPainter({
    required this.transactions,
    required this.lineColor,
    required this.gridColor,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final balances = <double>[];
    double runningBalance = 0;

    for (final transaction in transactions) {
      runningBalance += transaction.isIncome ? transaction.amount : -transaction.amount;
      balances.add(runningBalance);
    }

    final minValue = math.min(0, balances.reduce(math.min));
    final maxValue = math.max(0, balances.reduce(math.max));
    final range = maxValue - minValue == 0 ? 1 : maxValue - minValue;
    final chartRect = Rect.fromLTWH(0, 8, size.width, size.height - 24);

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (int i = 0; i <= 3; i++) {
      final y = chartRect.top + chartRect.height * (i / 3);
      canvas.drawLine(Offset(chartRect.left, y), Offset(chartRect.right, y), gridPaint);
    }

    final zeroY = chartRect.bottom - ((0 - minValue) / range) * chartRect.height;
    final zeroPaint = Paint()
      ..color = gridColor.withValues(alpha: 0.9)
      ..strokeWidth = 1.5;

    canvas.drawLine(Offset(chartRect.left, zeroY), Offset(chartRect.right, zeroY), zeroPaint);

    final path = Path();

    for (int i = 0; i < balances.length; i++) {
      final x = balances.length == 1
          ? chartRect.center.dx
          : chartRect.left + (chartRect.width * i / (balances.length - 1));
      final y = chartRect.bottom - ((balances[i] - minValue) / range) * chartRect.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, linePaint);

    final pointPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < balances.length; i++) {
      final x = balances.length == 1
          ? chartRect.center.dx
          : chartRect.left + (chartRect.width * i / (balances.length - 1));
      final y = chartRect.bottom - ((balances[i] - minValue) / range) * chartRect.height;
      canvas.drawCircle(Offset(x, y), 4, pointPaint);
    }

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Saldo acumulado no período',
        style: TextStyle(color: textColor, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    textPainter.paint(canvas, Offset(0, size.height - 14));
  }

  @override
  bool shouldRepaint(covariant _BalanceChartPainter oldDelegate) {
    return oldDelegate.transactions != transactions ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.textColor != textColor;
  }
}
