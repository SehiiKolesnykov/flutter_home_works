import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../models/habit.dart';
import '../widgets/stat_card.dart';

class HabitDetailsScreen extends StatelessWidget {
  const HabitDetailsScreen({super.key});

  double _calculateProgress(Habit habit) {
    if (habit.progress.isEmpty) return 0.0;
    final totalDays = DateTime.now().difference(habit.startDate).inDays + 1;
    final completed = habit.progress.values.where((v) => v).length;
    return (completed / totalDays).clamp(0.0, 1.0);
  }

  int _calculateStreak(Habit habit) {
    int streak = 0;
    DateTime current = DateTime.now();
    while (true) {
      String dateKey = DateFormat('yyyy-MM-dd').format(current);
      if (habit.progress[dateKey] == true) {
        streak++;
        current = current.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }

  @override
  Widget build(BuildContext context) {
    final Habit habit = ModalRoute.of(context)!.settings.arguments as Habit;
    final progress = _calculateProgress(habit);
    final streak = _calculateStreak(habit);
    final totalDays = DateTime.now().difference(habit.startDate).inDays + 1;
    final completedDays = habit.progress.values.where((v) => v).length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Text(habit.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      Text(habit.frequency, style: const TextStyle(fontSize: 18, color: Colors.white70)),
                      const SizedBox(height: 24),
                      Icon(
                        habit.progress[DateFormat('yyyy-MM-dd').format(DateTime.now())] ?? false ? Icons.check_circle_outline : Icons.radio_button_unchecked,
                        size: 80,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text('Статистика', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Поточний стрік',
                    value: '$streak днів',
                    icon: Icons.local_fire_department,
                    iconColor: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StatCard(
                    title: 'Виконано днів',
                    value: '$completedDays з $totalDays',
                    icon: Icons.calendar_today,
                    iconColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text('Загальний прогрес', style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 16),
            LinearPercentIndicator(
              lineHeight: 20,
              percent: progress,
              center: Text('${(progress * 100).round()}%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              backgroundColor: Colors.white24,
              progressColor: Colors.green[400],
              barRadius: const Radius.circular(20),
            ),
            const SizedBox(height: 40),
            Card(
              child: ListTile(
                leading: const Icon(Icons.event, color: Colors.white),
                title: const Text('Дата початку', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                subtitle: Text(DateFormat('dd MMMM yyyy', 'uk').format(habit.startDate), style: const TextStyle(color: Colors.white70)),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}