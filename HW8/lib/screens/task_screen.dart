import 'package:flutter/material.dart';
import 'package:hw_8/models/task.dart';

class TaskScreen extends StatefulWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const TaskScreen({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _save() {
    widget.task.title = _titleController.text.trim();
    widget.task.description = _descController.text;
    widget.onUpdate();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редагування завдання')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: 'task_${widget.task.id}',
              child: Material(
                child: TextField(
                  controller: _titleController,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    labelText: 'Заголовок',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descController,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Опис',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _save,
                    child: const Text('Зберегти'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      widget.onDelete();
                      Navigator.pop(context);
                    },
                    child: const Text('Видалити'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}