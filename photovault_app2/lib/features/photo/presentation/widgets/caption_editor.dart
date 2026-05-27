import 'package:flutter/material.dart';

// Widget reutilizável para editar legenda e audiodescrição
// Encapsula o TextField estilizado para fundo escuro
class CaptionEditor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int    maxLines;

  const CaptionEditor({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
        style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 13)),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        maxLines:   maxLines,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText:   hint,
          hintStyle:  const TextStyle(color: Colors.white38),
          filled:     true,
          fillColor:  Colors.white.withValues(alpha: .07),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white24)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white24)),
        ),
      ),
    ]);
  }
}