import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;
  final Function(String, bool) onToggleComplete;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onTap,
    required this.onToggleComplete,
  });

  double get progressPercentage {
    if (habit.progress.isEmpty) return 0.0;
    final totalDays = DateTime.now().difference(habit.startDate).inDays + 1;
    final completed = habit.progress.values.where((v) => v).length;
    return (completed / totalDays).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final isCompletedToday = habit.progress[today] ?? false;
    final progress = progressPercentage;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      habit.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    isCompletedToday ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isCompletedToday ? Colors.green : Colors.white,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(habit.frequency, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 20),
              Center(
                child: CircularPercentIndicator(
                  radius: 40,
                  lineWidth: 8,
                  percent: progress,
                  center: Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  progressColor: isCompletedToday ? Colors.green : Colors.white,
                  backgroundColor: Colors.white30,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: isCompletedToday,
                    onChanged: (value) => onToggleComplete(habit.id, value ?? false),
                    shape: const CircleBorder(),
                    fillColor: MaterialStateProperty.all(Colors.white),
                    checkColor: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}