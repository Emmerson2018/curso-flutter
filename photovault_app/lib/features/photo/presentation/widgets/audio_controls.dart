import 'package:flutter/material.dart';

// Widget reutilizável para controles de áudio (Play / Pause / Stop)
// Recebe apenas callbacks — sem estado próprio
class AudioControls extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onStop;

  const AudioControls({
    super.key,
    required this.onPlay,
    required this.onPause,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12)),
      child: Row(children: [
        const Icon(Icons.volume_up,
          color: Colors.white70),
        const SizedBox(width: 8),
        const Text('Audiodescrição',
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        const Spacer(),
        // Semantics garante acessibilidade para TalkBack / VoiceOver
        Semantics(label: 'Reproduzir audiodescrição', button: true,
          child: IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.white),
            tooltip: 'Reproduzir', onPressed: onPlay)),
        Semantics(label: 'Pausar audiodescrição', button: true,
          child: IconButton(
            icon: const Icon(Icons.pause, color: Colors.white70),
            tooltip: 'Pausar', onPressed: onPause)),
        Semantics(label: 'Parar audiodescrição', button: true,
          child: IconButton(
            icon: const Icon(Icons.stop, color: Colors.white70),
            tooltip: 'Parar', onPressed: onStop)),
      ]),
    );
  }
}