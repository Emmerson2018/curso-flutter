import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/goal.dart';
import '../providers/goals_provider.dart';
import 'add_goal_screen.dart';

// Enum para os filtros de aba
enum GoalFilter { ativas, concluidas, atrasadas }

// ConsumerStatefulWidget = StatefulWidget + acesso ao ref do Riverpod
class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});
  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  GoalFilter _filter = GoalFilter.ativas;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // ref.watch: observa e reconstrói quando o provider muda
    // Só use ref.watch dentro do build()!
    final summary = ref.watch(summaryProvider);

    // Seleciona a lista conforme o filtro ativo
    final goals = switch (_filter) {
      GoalFilter.ativas     => ref.watch(activeGoalsProvider),
      GoalFilter.concluidas => ref.watch(doneGoalsProvider),
      GoalFilter.atrasadas  => ref.watch(overdueGoalsProvider),
    };

    // Verifica o estado do AsyncNotifier (loading / error / data)
    final goalsAsync = ref.watch(goalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎯 Minhas Metas'),
        centerTitle: true,
      ),
      body: goalsAsync.when(
        // Estado de carregamento (lendo SharedPreferences)
        loading: () => const Center(child: CircularProgressIndicator()),
        // Estado de erro
        error: (e, _) => Center(child: Text('Erro: $e')),
        // Estado com dados
        data: (_) => Column(children: [
          // ── Cartão de resumo ──
          _SummaryCard(summary: summary),
          // ── Filtros ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(children: [
              for (final f in GoalFilter.values)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: FilterChip(
                      label: Text(switch (f) {
                        GoalFilter.ativas     => 'Ativas (${summary.active})',
                        GoalFilter.concluidas => 'Concluídas (${summary.done})',
                        GoalFilter.atrasadas  => 'Atrasadas (${summary.overdue})',
                      }, style: const TextStyle(fontSize: 11)),
                      selected: _filter == f,
                      onSelected: (_) => setState(() => _filter = f),
                      showCheckmark: false,
                    ),
                  ),
                ),
            ]),
          ),
          // ── Lista de metas ──
          Expanded(
            child: goals.isEmpty
                ? Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.flag_outlined, size: 64, color: scheme.outline),
                      const SizedBox(height: 12),
                      Text(
                        'Nenhuma meta neste filtro.',
                        style: TextStyle(color: scheme.outline),
                      ),
                    ]),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
                    itemCount: goals.length,
                    itemBuilder: (_, i) => _GoalTile(goal: goals[i]),
                  ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddGoalScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nova Meta'),
      ),
    );
  }
}

// ── Cartão de resumo ──────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  final ({int total, int done, int active, int overdue, double avg}) summary;
  const _SummaryCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _Stat('${summary.total}',   'Total',      scheme),
            _Stat('${summary.active}',  'Ativas',     scheme),
            _Stat('${summary.done}',    'Concluídas', scheme),
            _Stat('${summary.overdue}', 'Atrasadas',  scheme),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Text(
              '${summary.avg.round()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.onPrimaryContainer,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: summary.avg / 100,
                  minHeight: 8,
                  backgroundColor: scheme.primary.withValues(alpha: .2),
                  valueColor: AlwaysStoppedAnimation(scheme.primary),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  final ColorScheme scheme;
  const _Stat(this.value, this.label, this.scheme);
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold,
      color: scheme.onPrimaryContainer)),
    Text(label, style: TextStyle(fontSize: 11, color: scheme.onPrimaryContainer)),
  ]);
}

// ── Tile de cada meta ─────────────────────────────────────────────
// ConsumerWidget: como StatelessWidget, mas com ref para acessar providers
class _GoalTile extends ConsumerWidget {
  final Goal goal;
  const _GoalTile({required this.goal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(goal.category.emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                goal.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  decoration: goal.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            Text(
              '${goal.progress}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: goal.isDone ? scheme.primary : scheme.onSurface,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 18),
              onPressed: () {
                // ref.read — usa em callbacks, não em build()
                ref.read(goalsProvider.notifier).remove(goal.id);
              },
            ),
          ]),
          // Prazo
          Text(
            goal.isOverdue ? '⚠️ Prazo expirado' :
            goal.isDone    ? '✅ Concluída' :
            'Prazo: ${_formatDate(goal.deadline)}',
            style: TextStyle(
              fontSize: 12,
              color: goal.isOverdue ? scheme.error : scheme.onSurfaceVariant,
            ),
          ),
          // Slider de progresso
          Slider(
            value: goal.progress.toDouble(),
            min: 0, max: 100, divisions: 10,
            label: '${goal.progress}%',
            onChanged: (v) => ref
                .read(goalsProvider.notifier)
                .updateProgress(goal.id, v.round()),
          ),
        ]),
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2,'0')}/${d.month.toString().padLeft(2,'0')}/${d.year}';
}