// ============================================================
// AULA 7 — Navegação com go_router
// Drawer global com Semantics em cada item — Aula 10.
// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/providers/acessibilidade_provider.dart';
import '../../core/theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final acess = context.watch<AcessibilidadeProvider>();

    return Drawer(
      child: Column(
        children: [
          // Cabeçalho com identidade visual BioDiorama/IFAM
          DrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.corVerde),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.forest, size: 48, color: Colors.white),
                const SizedBox(height: 8),
                const Text(
                  'BioDiorama IA',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Amazônia · IA · Acessibilidade',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const _Item(
                  icone: Icons.home_outlined,
                  titulo: 'Início',
                  rota: '/',
                  descricaoAcessivel: 'Tela inicial do BioDiorama IA',
                ),
                const _Item(
                  icone: Icons.edit_note,
                  titulo: 'Analisar por texto',
                  rota: '/analise-texto',
                  descricaoAcessivel: 'Descrever diorama em texto para análise pela IA',
                ),
                const _Item(
                  icone: Icons.camera_alt,
                  titulo: 'Analisar por imagem',
                  rota: '/analise-imagem',
                  descricaoAcessivel: 'Fotografar diorama para análise pela IA',
                ),
                const _Item(
                  icone: Icons.biotech,
                  titulo: 'Desenvolvimento Embrionário',
                  rota: '/embriologia',
                  descricaoAcessivel: 'Módulo educacional sobre os 8 estágios embrionários',
                ),
                const _Item(
                  icone: Icons.history,
                  titulo: 'Histórico',
                  rota: '/historico',
                  descricaoAcessivel: 'Análises anteriores de dioramas',
                ),
                const Divider(),
                _Item(
                  icone: Icons.accessibility_new,
                  titulo: 'Acessibilidade',
                  rota: '/acessibilidade',
                  descricaoAcessivel: 'Configurar Libras, audiodescrição e tamanho de fonte',
                  // Indicador visual quando há recursos ativos
                  badge: (acess.librasAtivado || acess.audioDescricaoAtivado)
                      ? '●'
                      : null,
                ),
                const _Item(
                  icone: Icons.info_outline,
                  titulo: 'Sobre',
                  rota: '/sobre',
                  descricaoAcessivel: 'Informações sobre o projeto BioDiorama IA',
                ),
              ],
            ),
          ),

          // Rodapé com indicadores de acessibilidade ativos
          if (acess.librasAtivado || acess.audioDescricaoAtivado)
            Container(
              padding: const EdgeInsets.all(12),
              color: AppTheme.corLibras.withValues(alpha: 0.08),
              child: Row(
                children: [
                  if (acess.librasAtivado)
                    const Chip(
                      label: Text('Libras ativo'),
                      avatar: Icon(Icons.sign_language, size: 16),
                    ),
                  if (acess.librasAtivado && acess.audioDescricaoAtivado)
                    const SizedBox(width: 8),
                  if (acess.audioDescricaoAtivado)
                    const Chip(
                      label: Text('Áudio ativo'),
                      avatar: Icon(Icons.volume_up, size: 16),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.icone,
    required this.titulo,
    required this.rota,
    required this.descricaoAcessivel,
    this.badge,
  });

  final IconData icone;
  final String titulo;
  final String rota;
  final String descricaoAcessivel;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: descricaoAcessivel,
      hint: 'Toque duas vezes para navegar',
      button: true,
      child: ListTile(
        leading: Icon(icone),
        title: Text(titulo),
        trailing: badge != null
            ? Text(badge!, style: const TextStyle(color: AppTheme.corLibras))
            : null,
        onTap: () {
          Navigator.of(context).pop(); // fecha o drawer
          context.go(rota);
        },
      ),
    );
  }
}
