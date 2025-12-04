import 'package:flutter/material.dart';
import 'package:hw_8/screens/todo_list_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            title: 'TO DO List',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              useMaterial3: true,
            ),
            home: const ToDoListScreen(),
          );
        },
    );
  }
}
