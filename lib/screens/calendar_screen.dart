import 'package:flutter/material.dart';

import '../models/task_item.dart';
import '../widgets/task_list_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
    required this.userName,
    required this.initialTasks,
  });

  static const routeName = '/calendar';

  final String userName;
  final List<TaskItem> initialTasks;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _selectedDate;
  late List<TaskItem> _tasks;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _tasks = [...widget.initialTasks];
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF4FD8)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _showAddTaskDialog() {
    final controller = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Nova tarefa do dia'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Ex: Estudar widgets avançados',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                final title = controller.text.trim();
                if (title.isEmpty) return;
                setState(() {
                  _tasks.add(
                    TaskItem(title: title, date: _selectedDate, isCompleted: false),
                  );
                });
                Navigator.of(ctx).pop();
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _toggleTask(TaskItem task) {
    setState(() => task.isCompleted = !task.isCompleted);
  }

  void _removeTask(TaskItem task) {
    setState(() => _tasks.remove(task));
  }

  List<TaskItem> get _tasksForSelectedDate {
    final list = _tasks.where((task) => _isSameDate(task.date, _selectedDate)).toList();
    list.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });
    return list;
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _tasksForSelectedDate;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF050026), Color(0xFF3A0CA3), Color(0xFFF72585)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, ${widget.userName} ✨',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Selecione uma data e organize seu dia com estilo.',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white.withValues(alpha: 0.14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month_rounded,
                          color: Colors.cyanAccent),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Dia ${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _pickDate,
                        child: const Text('Trocar'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TaskListCard(
                    tasks: tasks,
                    onToggle: _toggleTask,
                    onDelete: _removeTask,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTaskDialog,
        backgroundColor: const Color(0xFF00F5D4),
        foregroundColor: const Color(0xFF22033B),
        icon: const Icon(Icons.add_task),
        label: const Text('Adicionar tarefa'),
      ),
    );
  }
}
