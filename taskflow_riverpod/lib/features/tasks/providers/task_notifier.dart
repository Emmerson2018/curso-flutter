import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/task.dart';

// 1. O Enum precisa vir primeiro para que os Providers conheçam o tipo 'TaskFilter'
enum TaskFilter { all, pending, done }

// Provedor da lista de tarefas
final taskNotifierProvider = NotifierProvider<TaskNotifier, List<Task>>(
  TaskNotifier.new,
);

// Provedor do filtro (Agora o Dart sabe perfeitamente o que é TaskFilter)
final taskFilterProvider = NotifierProvider<TaskFilterNotifier, TaskFilter>(
  TaskFilterNotifier.new,
);

final filteredTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskNotifierProvider);
  final filter = ref.watch(taskFilterProvider);

  return switch (filter) {
    TaskFilter.all => tasks,
    TaskFilter.pending => tasks.where((task) => !task.isDone).toList(),
    TaskFilter.done => tasks.where((task) => task.isDone).toList(),
  };
});

// Classe gerenciadora do filtro
class TaskFilterNotifier extends Notifier<TaskFilter> {
  @override
  TaskFilter build() => TaskFilter.all;

  void setFilter(TaskFilter newFilter) {
    state = newFilter;
  }
}

// Classe gerenciadora das tarefas
class TaskNotifier extends Notifier<List<Task>> {
  @override
  List<Task> build() {
    return const [];
  }

  void addTask(String title) {
    final cleanTitle = title.trim();
    if (cleanTitle.isEmpty) return;

    final task = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: cleanTitle,
    );

    state = [...state, task];
  }

  void toggleTask(String id) {
    state = [
      for (final task in state)
        if (task.id == id) task.copyWith(isDone: !task.isDone) else task,
    ];
  }

  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}