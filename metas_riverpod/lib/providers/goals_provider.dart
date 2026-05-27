import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/goal.dart';

const _kGoalsKey = 'goals_data';

// ── GoalsNotifier ─────────────────────────────────────────────────
class GoalsNotifier extends AsyncNotifier<List<Goal>> {
  @override
  Future<List<Goal>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final raw   = prefs.getString(_kGoalsKey);
    if (raw == null || raw.isEmpty) return [];
    try {
      return Goal.listFromJson(raw);
    } catch (_) {
      return []; 
    }
  }

  Future<void> _persist(List<Goal> goals) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kGoalsKey, Goal.listToJson(goals));
  }

  // Adiciona uma nova meta ao topo da lista
  Future<void> add(Goal goal) async {
    // No Riverpod 3, usamos '.value' para obter o valor atual (pode ser nulo)
    final current = state.value ?? [];
    final next    = [goal, ...current];
    state = AsyncData(next);
    await _persist(next);
  }

  // Atualiza o progresso de uma meta pelo id
  Future<void> updateProgress(String id, int progress) async {
    // Alterado para '.value'
    final current = state.value ?? [];
    final next = [
      for (final g in current)
        if (g.id == id) g.copyWith(progress: progress.clamp(0, 100)) else g,
    ];
    state = AsyncData(next);
    await _persist(next);
  }

  // Remove uma meta pelo id
  Future<void> remove(String id) async {
    // Alterado para '.value'
    final current = state.value ?? [];
    final next    = current.where((g) => g.id != id).toList();
    state = AsyncData(next);
    await _persist(next);
  }
}

// ── Providers ─────────────────────────────────────────────────────

final goalsProvider =
    AsyncNotifierProvider<GoalsNotifier, List<Goal>>(GoalsNotifier.new);

final activeGoalsProvider = Provider<List<Goal>>((ref) {
  // CORREÇÃO: No Riverpod 3, extraímos o valor de AsyncValue usando apenas '.value'
  final all = ref.watch(goalsProvider).value ?? [];
  return all.where((g) => g.isActive).toList();
});

final doneGoalsProvider = Provider<List<Goal>>((ref) {
  // Alterado para '.value'
  final all = ref.watch(goalsProvider).value ?? [];
  return all.where((g) => g.isDone).toList();
});

final overdueGoalsProvider = Provider<List<Goal>>((ref) {
  // Alterado para '.value'
  final all = ref.watch(goalsProvider).value ?? [];
  return all.where((g) => g.isOverdue).toList();
});

final summaryProvider = Provider((ref) {
  // Alterado para '.value'
  final all     = ref.watch(goalsProvider).value ?? [];
  final done    = all.where((g) => g.isDone).length;
  final active  = all.where((g) => g.isActive).length;
  final overdue = all.where((g) => g.isOverdue).length;
  final avg     = all.isEmpty
      ? 0.0
      : all.map((g) => g.progress).fold(0, (a, b) => a + b) / all.length;
  return (
    total:   all.length,
    done:    done,
    active:  active,
    overdue: overdue,
    avg:     avg,
  );
});