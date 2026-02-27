import 'package:flutter/material.dart';

import 'models/task_item.dart';
import 'screens/auth_screen.dart';
import 'screens/calendar_screen.dart';

void main() {
  runApp(const VibrantTaskApp());
}

class VibrantTaskApp extends StatelessWidget {
  const VibrantTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pulse Planner',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7F00FF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF12052D),
        fontFamily: 'Roboto',
      ),
      home: const AuthScreen(),
      routes: {
        CalendarScreen.routeName: (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          final userName = args?['userName'] as String? ?? 'Usuário';
          final tasks = (args?['tasks'] as List<TaskItem>?) ?? [];
          return CalendarScreen(userName: userName, initialTasks: tasks);
        },
      },
    );
  }
}
