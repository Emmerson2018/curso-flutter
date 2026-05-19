import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/task.dart';
import '../../providers/task_notifier.dart';

class TaskTile extends ConsumerWidget {
  final Task task;

  const TaskTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: (_) {
          ref.read(taskNotifierProvider.notifier).toggleTask(task.id);
        },
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        tooltip: 'Remover tarefa',
        onPressed: () {
          ref.read(taskNotifierProvider.notifier).removeTask(task.id);
        },
      ),
    );
  }
}