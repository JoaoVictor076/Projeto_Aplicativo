import 'package:flutter/material.dart';

import '../models/task_item.dart';

class TaskListCard extends StatelessWidget {
  const TaskListCard({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.onDelete,
  });

  final List<TaskItem> tasks;
  final ValueChanged<TaskItem> onToggle;
  final ValueChanged<TaskItem> onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1248).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF4CC9F0).withValues(alpha: 0.45)),
      ),
      child: tasks.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma tarefa neste dia.\nClique em "Adicionar tarefa" para começar!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.separated(
              itemCount: tasks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, index) {
                final task = tasks[index];
                return Container(
                  decoration: BoxDecoration(
                    color: task.isCompleted
                        ? const Color(0xFF264653).withValues(alpha: 0.8)
                        : const Color(0xFF7209B7).withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      activeColor: const Color(0xFF00F5D4),
                      onChanged: (_) => onToggle(task),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(
                      task.isCompleted ? 'Concluída' : 'Pendente',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: IconButton(
                      tooltip: 'Remover tarefa',
                      onPressed: () => onDelete(task),
                      icon: const Icon(Icons.delete_outline_rounded,
                          color: Colors.white),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
