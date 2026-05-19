import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/task_notifier.dart';
import 'widgets/task_form.dart';
import 'widgets/task_tile.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(filteredTasksProvider);
    final allTasks = ref.watch(taskNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('TaskFlow (${allTasks.length})'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const TaskForm(),
          const _TaskFilters(),
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Text('Nenhuma tarefa encontrada.'),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskTile(task: task);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _TaskFilters extends ConsumerWidget {
  const _TaskFilters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(taskFilterProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SegmentedButton<TaskFilter>(
        segments: const [
          ButtonSegment(value: TaskFilter.all, label: Text('Todas')),
          ButtonSegment(value: TaskFilter.pending, label: Text('Pendentes')),
          ButtonSegment(value: TaskFilter.done, label: Text('Concluídas')),
        ],
        selected: {selected},
        onSelectionChanged: (values) {
          // CORREÇÃO: Em vez de usar '.state = ...', chamamos o método do nosso Notifier
          ref.read(taskFilterProvider.notifier).setFilter(values.first);
        },
      ),
    );
  }
}