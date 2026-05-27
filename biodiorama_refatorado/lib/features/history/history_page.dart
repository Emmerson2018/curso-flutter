// ============================================================
// AULA 7 — FutureBuilder + HistoryService com DioramaAnalysis
// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/history_service.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/diorama_analysis.dart';
import '../../shared/widgets/acessibilidade_bar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<DioramaAnalysis>> _futureHistorico;

  @override
  void initState() {
    super.initState();
    _futureHistorico = HistoryService().carregarTodos();
  }

  void _recarregar() =>
      setState(() => _futureHistorico = HistoryService().carregarTodos());

  Future<void> _limpar() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Limpar histórico?'),
        content:
            const Text('Todas as análises salvas serão removidas.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Limpar')),
        ],
      ),
    );
    if (confirmar == true) {
      await HistoryService().limpar();
      _recarregar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Limpar histórico',
            onPressed: _limpar,
          ),
        ],
      ),
      bottomNavigationBar: const AcessibilidadeBar(),
      body: FutureBuilder<List<DioramaAnalysis>>(
        future: _futureHistorico,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar histórico: ${snapshot.error}'),
            );
          }

          final itens = snapshot.data ?? [];

          if (itens.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  const Text(
                    'Nenhuma análise realizada ainda.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => context.push('/analise-imagem'),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Fazer primeira análise'),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: itens.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) => _ItemHistorico(
              analise: itens[i],
              onTap: () => context.push('/resultado', extra: itens[i]),
            ),
          );
        },
      ),
    );
  }
}

class _ItemHistorico extends StatelessWidget {
  const _ItemHistorico({required this.analise, required this.onTap});

  final DioramaAnalysis analise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Aula 3: map() + join() para gerar texto de espécies
    final nomesEspecies = analise.especiesDetectadas
        .map((e) => e.nome)
        .join(', ');
    final pct = (analise.confiancaIA * 100).toStringAsFixed(0);
    final data = '${analise.dataAnalise.day}/${analise.dataAnalise.month}'
        '/${analise.dataAnalise.year}';

    return Semantics(
      label: 'Análise de $data. Espécies: $nomesEspecies. Confiança: $pct porcento.',
      hint: 'Toque duas vezes para ver detalhes',
      button: true,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.corVerde.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.eco,
                      color: AppTheme.corVerde, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nomesEspecies.isEmpty
                            ? 'Análise sem espécies'
                            : nomesEspecies,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$data · $pct% de confiança',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
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
