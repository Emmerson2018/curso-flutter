// ============================================================
// AULA 7 — AcessibilidadeProvider + Widgets reativos
// Barra de acessibilidade que aparece em todas as telas.
// Consome AcessibilidadeProvider via context.watch().
// ============================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/acessibilidade_provider.dart';
import '../../core/theme/app_theme.dart';

class AcessibilidadeBar extends StatelessWidget {
  const AcessibilidadeBar({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch() reconstrói a barra quando o provider notifica
    final acess = context.watch<AcessibilidadeProvider>();

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Botão Libras
          _BotaoAcessibilidade(
            icone: Icons.sign_language,
            rotulo: 'Libras',
            ativo: acess.librasAtivado,
            corAtivo: AppTheme.corLibras,
            onTap: acess.toggleLibras,
          ),
          // Botão Audiodescrição
          _BotaoAcessibilidade(
            icone: Icons.record_voice_over,
            rotulo: 'Áudio',
            ativo: acess.audioDescricaoAtivado,
            corAtivo: AppTheme.corVerde,
            onTap: acess.toggleAudioDescricao,
          ),
          // Botão Alto Contraste
          _BotaoAcessibilidade(
            icone: Icons.contrast,
            rotulo: 'Contraste',
            ativo: acess.altoContrasteAtivado,
            corAtivo: Colors.orange.shade800,
            onTap: acess.toggleAltoContraste,
          ),
        ],
      ),
    );
  }
}

class _BotaoAcessibilidade extends StatelessWidget {
  const _BotaoAcessibilidade({
    required this.icone,
    required this.rotulo,
    required this.ativo,
    required this.corAtivo,
    required this.onTap,
  });

  final IconData icone;
  final String rotulo;
  final bool ativo;
  final Color corAtivo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$rotulo: ${ativo ? "ativado" : "desativado"}',
      hint: 'Toque duas vezes para ${ativo ? "desativar" : "ativar"}',
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icone,
                color: ativo ? corAtivo : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 2),
              Text(
                rotulo,
                style: TextStyle(
                  fontSize: 11,
                  color: ativo ? corAtivo : Colors.grey,
                  fontWeight: ativo ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
