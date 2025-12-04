import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewTaskWidget extends StatefulWidget {
  final VoidCallback onAddTask;
  final TextEditingController controller;

  const NewTaskWidget({
    super.key,
    required this.onAddTask,
    required this.controller,
  });

  @override
  State<NewTaskWidget> createState() => _NewTaskWidgetState();
}

class _NewTaskWidgetState extends State<NewTaskWidget> {

  @override
  Widget build(BuildContext context) {
    final isEmpty = widget.controller.text
        .trim()
        .isEmpty;

    return Material(
      borderRadius: BorderRadius.circular(36),
      color: Colors.transparent,
      child: Container(
        width: 97.w,
        height: 6.h,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(36)
        ),

        child: Row(
          children: [
            const SizedBox(width: 20,),
            Expanded(
              child: TextField(
                controller: widget.controller,
                decoration: const InputDecoration(
                  hintText: "New task",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(fontSize: 16.sp),
                onChanged: (_) => setState(() {}),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.send, color: isEmpty ? Colors.grey : Colors.blue,),
              onPressed: isEmpty ? null : widget.onAddTask,
            ),
          ],
        ),
      ),
    );
  }
}
