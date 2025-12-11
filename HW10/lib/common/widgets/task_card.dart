import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;

  const TaskCard({super.key, required this.task, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: task.gradientColors),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: task.gradientColors.first.withValues(alpha: 0.7),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 6,
              top: 0,
              child: Icon(task.icon, size: 140, color: Colors.white.withValues(alpha: 0.2)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(task.icon, size: 40, color: Colors.white),
                  const SizedBox(height: 12),
                  Text(task.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(task.subtitle, style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.7))),
                ],
              ),
            ),
            const Positioned(
              right: 20,
              bottom: 20,
              child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 24),
            ),
          ],
        ),
      ),
    );
  }
}