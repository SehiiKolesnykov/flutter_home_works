import 'package:flutter/material.dart';
import 'package:hw_8/models/task.dart';
import 'package:hw_8/screens/task_screen.dart';
import 'package:hw_8/widgets/task_item_widget.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;
  final List<AnimationController> animationControllers;
  final Function(int, int) onReorder;
  final Function(int) onToggle;
  final Function(int) onRemove;
  final VoidCallback onListUpdate;

  const TasksList({
    super.key,
    required this.tasks,
    required this.animationControllers,
    required this.onReorder,
    required this.onToggle,
    required this.onRemove,
    required this.onListUpdate,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('Немає завдань', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 120),
      itemCount: tasks.length,
      onReorder: onReorder,

      proxyDecorator: (child, index, animation) => Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(16),
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 1.0,
            end: 1.07,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      ),

      itemBuilder: (context, index) {
        final controller = animationControllers[index];

        return SizeTransition(
          key: ValueKey(tasks[index].id),
          sizeFactor: CurvedAnimation(
            parent: controller,
            curve: Curves.easeOutCubic,
          ),
          axisAlignment: -1.0,
          child: TaskItem(
            task: tasks[index],
            onToggle: () => onToggle(index),
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (_, __, ___) => TaskScreen(
                    task: tasks[index],
                    onDelete: () => onRemove(index),
                    onUpdate: onListUpdate,
                  ),
                  transitionsBuilder: (_, a, __, child) =>
                      FadeTransition(opacity: a, child: child),
                ),
              );
            },
            onDelete: () => onRemove(index),
          ),
        );
      },
    );
  }
}
