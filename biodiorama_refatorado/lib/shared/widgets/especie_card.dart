// ============================================================
// AULA 6 — Widget reutilizável com Semantics
// Exibido na ResultPage e no HistoryPage.
// ============================================================

import 'package:flutter/material.dart';

import '../../domain/models/especie.dart';

class EspecieCard extends StatelessWidget {
  const EspecieCard({
    super.key,
    required this.especie,
    this.onTap,
  });

  final Especie especie;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final corStatus = especie.ameacadaExtincao
        ? Colors.red.shade700
        : Colors.green.shade700;
    final iconeStatus = especie.ameacadaExtincao
        ? Icons.warning_amber_rounded
        : Icons.check_circle_outline;

    // MergeSemantics agrupa ícone + texto para o TalkBack — Aula 10
    return MergeSemantics(
      child: Semantics(
        label: '${especie.nome}.'
            '${especie.ameacadaExtincao ? " Espécie ameaçada de extinção." : ""}'
            ' Bioma: ${especie.bioma}.',
        hint: onTap != null ? 'Toque duas vezes para ver detalhes' : null,
        button: onTap != null,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(iconeStatus, color: corStatus, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          especie.nome,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          especie.nomeCientifico,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            // Chip de bioma
                            Chip(
                              label: Text(
                                especie.bioma,
                                style: const TextStyle(fontSize: 12),
                              ),
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            if (especie.posicao != null) ...[
                              const SizedBox(width: 4),
                              Chip(
                                label: Text(
                                  especie.posicao!,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                padding: EdgeInsets.zero,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
