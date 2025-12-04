import 'package:flutter/material.dart';
import 'package:hw_8/models/task.dart';
import 'package:hw_8/widgets/new_task_widget.dart';
import 'package:hw_8/widgets/tasks_list_widget.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen ({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();

}

class _ToDoListScreenState extends State<ToDoListScreen> with TickerProviderStateMixin {

  final List<Task> _tasks = [];
  final List<AnimationController> _controllers = [];
  final TextEditingController _textController = TextEditingController();

  void _addTask() {
    final text = _textController.text.trim();

    if(text.isEmpty) return;

    final task = Task(text);

    final controller = AnimationController(
        vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    setState(() {
      _tasks.insert(0, task);
      _controllers.insert(0, controller);
    });

    controller.forward();
    _textController.clear();
  }

  void _removeTask(int index) {
    _controllers[index].reverse().then((_) {
      setState(() {
        _tasks.removeAt(index);
        _controllers.removeAt(index).dispose();
      });
    });
  }

  void _toggle(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final task = _tasks.removeAt(oldIndex);
      final controller = _controllers.removeAt(oldIndex);
      _tasks.insert(newIndex, task);
      _controllers.insert(newIndex, controller);
    });
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }

    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: const Text('To Do List'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),

      body: Stack(

        children: [

          TasksList(

              tasks: _tasks,
              animationControllers: _controllers,
              onReorder: _reorder,
              onToggle: _toggle,
              onRemove: _removeTask,
              onListUpdate: () => setState(() {}),

          ),

          Align(
            alignment: Alignment.bottomCenter,

            child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  child: NewTaskWidget(
                      onAddTask: _addTask,
                      controller: _textController,
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }
}