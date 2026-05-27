// ============================================================
// AULA 7 — AcessibilidadeProvider: tela de configuração
// Switches reativos + Slider de fonte — Aula 7
// ============================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/acessibilidade_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/acessibilidade_bar.dart';

class AccessibilitySettingsPage extends StatelessWidget {
  const AccessibilitySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch() reconstrói a tela quando qualquer pref muda
    final acess = context.watch<AcessibilidadeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Acessibilidade')),
      bottomNavigationBar: const AcessibilidadeBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Cabeçalho
          Text(
            'Personalize sua experiência',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'Suas preferências são salvas automaticamente.',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 20),

          // ── Libras ──────────────────────────────────────
          _SwitchAcessibilidade(
            icone: Icons.sign_language,
            corIcone: AppTheme.corLibras,
            titulo: 'Libras',
            subtitulo:
                'Exibe vídeos de intérprete em todas as análises e estágios.',
            valor: acess.librasAtivado,
            semanticLabel:
                'Libras: ${acess.librasAtivado ? "ativado" : "desativado"}',
            onChanged: (_) => acess.toggleLibras(),
          ),

          // ── Audiodescrição ───────────────────────────────
          _SwitchAcessibilidade(
            icone: Icons.record_voice_over,
            corIcone: AppTheme.corVerde,
            titulo: 'Audiodescrição automática',
            subtitulo:
                'Narra o resultado da análise e os estágios embrionários ao carregar.',
            valor: acess.audioDescricaoAtivado,
            semanticLabel:
                'Audiodescrição: ${acess.audioDescricaoAtivado ? "ativada" : "desativada"}',
            onChanged: (_) => acess.toggleAudioDescricao(),
          ),

          // ── Alto contraste ───────────────────────────────
          _SwitchAcessibilidade(
            icone: Icons.contrast,
            corIcone: Colors.orange.shade800,
            titulo: 'Alto contraste',
            subtitulo:
                'Aumenta o contraste visual para facilitar a leitura com baixa visão.',
            valor: acess.altoContrasteAtivado,
            semanticLabel:
                'Alto contraste: ${acess.altoContrasteAtivado ? "ativado" : "desativado"}',
            onChanged: (_) => acess.toggleAltoContraste(),
          ),

          const Divider(height: 32),

          // ── Tamanho de fonte ─────────────────────────────
          Semantics(
            label:
                'Tamanho de fonte: ${(acess.escalaFonte * 100).toInt()} por cento',
            slider: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.text_fields, color: AppTheme.corVerde),
                    const SizedBox(width: 8),
                    const Text(
                      'Tamanho de fonte',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      '${(acess.escalaFonte * 100).toInt()}%',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.corVerde),
                    ),
                  ],
                ),
                Text(
                  'Afeta todos os textos do aplicativo.',
                  style: TextStyle(
                      color: Colors.grey.shade600, fontSize: 13),
                ),
                Slider(
                  value: acess.escalaFonte,
                  min: 0.8,
                  max: 2.0,
                  divisions: 12,
                  activeColor: AppTheme.corVerde,
                  label: '${(acess.escalaFonte * 100).toInt()}%',
                  onChanged: acess.ajustarEscalaFonte,
                ),
                // Preview de texto com a escala atual
                _PreviewFonte(escala: acess.escalaFonte),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Botão restaurar padrões
          Semantics(
            label: 'Restaurar todas as configurações de acessibilidade para o padrão',
            button: true,
            child: OutlinedButton.icon(
              onPressed: () => _restaurarPadroes(context, acess),
              icon: const Icon(Icons.restore),
              label: const Text('Restaurar padrões'),
            ),
          ),
        ],
      ),
    );
  }

  void _restaurarPadroes(
      BuildContext context, AcessibilidadeProvider acess) {
    if (acess.librasAtivado) acess.toggleLibras();
    if (acess.audioDescricaoAtivado) acess.toggleAudioDescricao();
    if (acess.altoContrasteAtivado) acess.toggleAltoContraste();
    acess.ajustarEscalaFonte(1.0);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configurações restauradas.')),
    );
  }
}

// ----------------------------------------------------------
// Widget de switch reutilizável
// ----------------------------------------------------------
class _SwitchAcessibilidade extends StatelessWidget {
  const _SwitchAcessibilidade({
    required this.icone,
    required this.corIcone,
    required this.titulo,
    required this.subtitulo,
    required this.valor,
    required this.semanticLabel,
    required this.onChanged,
  });

  final IconData icone;
  final Color corIcone;
  final String titulo;
  final String subtitulo;
  final bool valor;
  final String semanticLabel;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      toggled: valor,
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: SwitchListTile(
          secondary: Icon(icone, color: corIcone),
          title: Text(titulo,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(subtitulo),
          value: valor,
          activeThumbColor: corIcone,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Preview de texto com escala atual
// ----------------------------------------------------------
class _PreviewFonte extends StatelessWidget {
  const _PreviewFonte({required this.escala});
  final double escala;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.corVerde.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Preview com ${(escala * 100).toInt()}%:',
              style:
                  const TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            'Peixe-boi amazônico — Espécie ameaçada',
            style: TextStyle(fontSize: 14 * escala),
          ),
          Text(
            'Trichechus inunguis · Rio Amazonas',
            style: TextStyle(
                fontSize: 12 * escala,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
