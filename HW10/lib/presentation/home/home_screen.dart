import 'package:flutter/material.dart';
import '../../common/models/task_model.dart';
import '../../common/widgets/task_card.dart';
import '../../features/task1_chatbot/presentation/chat_bot_screen.dart';
import '../../features/task2_timer/presentation/timer_screen.dart';
import '../../features/task3_realtime/presentation/realtime_data_screen.dart';
import '../../features/task4_api/presentation/api_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<TaskModel> tasks = const [
    TaskModel(
      title: 'Чат-бот',
      subtitle: 'Асинхронні відповіді',
      icon: Icons.chat_bubble_outline,
      gradientColors: [Colors.deepPurple, Colors.purpleAccent],
      screen: ChatBotScreen(),
    ),
    TaskModel(
      title: 'Зворотний відлік',
      subtitle: 'Таймер на базі Stream',
      icon: Icons.timer_outlined,
      gradientColors: [Colors.teal, Colors.cyan],
      screen: TimerScreen(),
    ),
    TaskModel(
      title: 'Real-Time Дані',
      subtitle: 'Потік даних з обробкою помилок',
      icon: Icons.show_chart,
      gradientColors: [Colors.orange, Colors.deepOrange],
      screen: RealTimeDataScreen(),
    ),
    TaskModel(
      title: 'Багатoeтапний API',
      subtitle: 'Імітація запиту з етапами',
      icon: Icons.cloud_queue,
      gradientColors: [Colors.indigo, Colors.blueAccent],
      screen: ApiScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1E2E), Color(0xFF2A2A40)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Асинхронні завдання', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8),
                    Text('Оберіть завдання для демонстрації', style: TextStyle(fontSize: 16, color: Colors.white70)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TaskCard(
                        task: task,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => task.screen)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}