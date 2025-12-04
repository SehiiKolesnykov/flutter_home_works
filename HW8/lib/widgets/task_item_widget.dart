import 'package:flutter/material.dart';
import 'package:hw_8/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = task.isCompleted;

    return Card(
      key: ValueKey(task.id),
      elevation: isCompleted ? 2 : 8,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isCompleted
            ? const BorderSide(color: Colors.grey, width: 1.5)
            : BorderSide.none,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: isCompleted ? Colors.grey.shade300 : Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
        ),

        leading: Checkbox(
          value: isCompleted,
          onChanged: (_) => onToggle(),
          activeColor: Colors.green,
          checkColor: Colors.white,
          shape: const CircleBorder(),
          side: BorderSide(
            color: isCompleted ? Colors.grey.shade700 : Colors.grey,
            width: 2,
          ),
        ),

        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: isCompleted ? Colors.grey.shade700 : Colors.black87,
            decoration: isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationThickness: 3,
            decorationColor: Colors.grey.shade700,
          ),
        ),

        trailing: isCompleted
            ? IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.redAccent,
            size: 28,),
          onPressed: onDelete,
          tooltip: "Видалити",
        )
            : const Icon(Icons.drag_handle, color: Colors.grey, size: 28,),

        onTap: isCompleted ? null : onTap,
      ),
    );
  }
}