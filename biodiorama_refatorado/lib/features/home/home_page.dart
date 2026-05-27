// ============================================================
// AULA 5 — Primeiro App Flutter: Widgets e Estado
// AULA 7 — Navegação com go_router
// HomePage com botões acessíveis e AcessibilidadeBar.
// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/providers/acessibilidade_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/acessibilidade_bar.dart';
import '../../shared/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final acess = context.watch<AcessibilidadeProvider>();

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('BioDiorama IA'),
        actions: [
          // Botão de acessibilidade sempre visível na AppBar — Aula 5
          Semantics(
            label: 'Configurações de acessibilidade',
            hint: 'Toque duas vezes para abrir',
            button: true,
            child: IconButton(
              icon: const Icon(Icons.accessibility_new),
              tooltip: 'Acessibilidade',
              onPressed: () => context.push('/acessibilidade'),
            ),
          ),
        ],
      ),
      // Barra de acessibilidade reativa — Aula 7
      bottomNavigationBar: const AcessibilidadeBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cabeçalho — Aula 5 (Semantics em texto de destaque)
              Semantics(
                header: true,
                child: Text(
                  'Explore a Amazônia com IA',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.corVerde,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Fotografe ou descreva um diorama biológico e receba '
                'análise em texto, audiodescrição e Libras.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Card: Analisar por texto
              _CardAcao(
                icone: Icons.edit_note,
                titulo: 'Analisar por texto',
                subtitulo: 'Digite uma descrição e receba a análise da IA',
                cor: AppTheme.corVerde,
                descricaoAcessivel:
                    'Analisar diorama por texto. Abrir campo de descrição',
                onTap: () => context.push('/analise-texto'),
              ),
              const SizedBox(height: 12),

              // Card: Analisar por imagem
              _CardAcao(
                icone: Icons.camera_alt,
                titulo: 'Analisar por imagem',
                subtitulo: 'Fotografe o diorama e envie para análise',
                cor: AppTheme.corVerdeClaro,
                descricaoAcessivel:
                    'Analisar diorama por imagem. Abrir câmera ou galeria',
                onTap: () => context.push('/analise-imagem'),
              ),
              const SizedBox(height: 12),

              // Card: Embriologia — módulo educacional
              _CardAcao(
                icone: Icons.biotech,
                titulo: 'Desenvolvimento Embrionário',
                subtitulo: '8 estágios com audiodescrição e Libras',
                cor: Colors.teal.shade700,
                descricaoAcessivel:
                    'Módulo educacional sobre desenvolvimento embrionário humano',
                onTap: () => context.push('/embriologia'),
              ),
              const SizedBox(height: 24),

              // Indicadores de acessibilidade ativos — feedback visual
              if (acess.librasAtivado || acess.audioDescricaoAtivado)
                _BannerAcessibilidade(
                  librasAtivo: acess.librasAtivado,
                  audioAtivo: acess.audioDescricaoAtivado,
                ),

              const SizedBox(height: 16),
              ExcludeSemantics(
                child: Text(
                  'IFAM — Instituto Federal do Amazonas\n'
                  'Curso de Flutter e Dart com foco em acessibilidade multimodal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Widget interno: card de ação principal
// ----------------------------------------------------------
class _CardAcao extends StatelessWidget {
  const _CardAcao({
    required this.icone,
    required this.titulo,
    required this.subtitulo,
    required this.cor,
    required this.descricaoAcessivel,
    required this.onTap,
  });

  final IconData icone;
  final String titulo;
  final String subtitulo;
  final Color cor;
  final String descricaoAcessivel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: descricaoAcessivel,
      hint: 'Toque duas vezes para abrir',
      button: true,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icone, color: cor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitulo,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Banner que indica recursos de acessibilidade ativos
// ----------------------------------------------------------
class _BannerAcessibilidade extends StatelessWidget {
  const _BannerAcessibilidade({
    required this.librasAtivo,
    required this.audioAtivo,
  });

  final bool librasAtivo;
  final bool audioAtivo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.corLibras.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.corLibras.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.accessibility_new, size: 18, color: AppTheme.corLibras),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              [
                if (librasAtivo) 'Libras ativo',
                if (audioAtivo) 'Audiodescrição ativa',
              ].join(' · '),
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.corLibras,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
