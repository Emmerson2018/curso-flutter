import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question.dart';
import '../widgets/answer_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  const QuizScreen({super.key, required this.questions});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int   _index     = 0;
  int   _score     = 0;
  int   _seconds   = 20;
  int?  _picked;
  bool _answered   = false;
  Timer? _timer;

  Question get _q  => widget.questions[_index];
  bool     get _last => _index == widget.questions.length - 1;

  @override
  void initState() { super.initState(); _startTimer(); }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = 20);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_seconds <= 1) _answer(-1);
      else setState(() => _seconds--);
    });
  }

  void _answer(int idx) {
    if (_answered) return;
    _timer?.cancel();
    setState(() {
      _answered = true;
      _picked   = idx;
      if (idx == _q.correct) _score++;
    });
    Future.delayed(const Duration(seconds: 2), _next);
  }

  void _next() {
    if (_last) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ResultScreen(
          score: _score, total: widget.questions.length),
      ));
    } else {
      setState(() { _index++; _answered = false; _picked = null; });
      _startTimer();
    }
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Progresso
          Row(children: [
            Text('${_index + 1}/${widget.questions.length}',
              style: TextStyle(fontWeight: FontWeight.bold,
                color: scheme.onSurface)),
            const SizedBox(width: 10),
            Expanded(child: LinearProgressIndicator(
              value: (_index + 1) / widget.questions.length,
              borderRadius: BorderRadius.circular(99),
            )),
            const SizedBox(width: 10),
            // AnimatedContainer sem withOpacity deprecated
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: 42, height: 42,
              decoration: BoxDecoration(shape: BoxShape.circle,
                color: switch (true) {
                  // switch expression Dart 3 — sem deprecated
                  _ when _seconds > 10 => Colors.green.shade700,
                  _ when _seconds > 5  => Colors.orange.shade700,
                  _                      => Colors.red.shade700,
                }),
              child: Center(child: Text('$_seconds',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            ),
          ]),
          const SizedBox(height: 12),
          // Chip de categoria
          Chip(
            label: Text(_q.category, style: const TextStyle(fontSize: 12)),
            backgroundColor: scheme.secondaryContainer,
            labelStyle: TextStyle(color: scheme.onSecondaryContainer),
          ),
          const SizedBox(height: 16),
          Text(_q.text, style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1.4)),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: _q.options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) => AnswerButton(
                text:      _q.options[i],
                index:     i,
                answered:  _answered,
                picked:    _picked,
                correct:   _q.correct,
                onTap:     () => _answer(i),
              ),
            ),
          ),
          if (_answered && _q.explanation.isNotEmpty)
            AnimatedOpacity(
              opacity: _answered ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              child: Container(
                margin: const EdgeInsets.only(top: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // withValues() — substituto moderno de withOpacity()
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Icon(Icons.lightbulb_outline, color: scheme.primary, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(_q.explanation,
                    style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant))),
                ]),
              ),
            ),
        ]),
      )),
    );
  }
}

// ── widgets/answer_button.dart ───────────────────────────
class AnswerButton extends StatelessWidget {
  final String text;
  final int    index, correct;
  final int?   picked;
  final bool   answered;
  final VoidCallback onTap;

  const AnswerButton({super.key, required this.text, required this.index,
    required this.correct, required this.picked, required this.answered,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isCorrect = index == correct;
    final isPicked  = index == picked;

    // Lógica de cor usando ColorScheme — sem MaterialColor deprecated
    final bgColor = !answered
        ? scheme.surfaceContainerHigh
        : isCorrect
          ? scheme.primaryContainer
          : isPicked
            ? scheme.errorContainer
            : scheme.surfaceContainerHigh;

    final textColor = !answered
        ? scheme.onSurface
        : isCorrect
          ? scheme.onPrimaryContainer
          : isPicked
            ? scheme.onErrorContainer
            : scheme.onSurface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: answered && isCorrect ? scheme.primary : scheme.outline,
          width: answered && isCorrect ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(radius: 13,
          backgroundColor: scheme.surface,
          child: Text('${String.fromCharCode(65 + index)}',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
              color: scheme.onSurface))),
        title: Text(text, style: TextStyle(color: textColor)),
        trailing: answered && isCorrect
          ? Icon(Icons.check_circle, color: scheme.primary)
          : answered && isPicked
            ? Icon(Icons.cancel, color: scheme.error)
            : null,
        onTap: answered ? null : onTap,
      ),
    );
  }
}