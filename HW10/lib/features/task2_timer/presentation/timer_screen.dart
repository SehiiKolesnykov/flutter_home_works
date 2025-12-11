import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Stream<int>? _timerStream;

  Stream<int> countdownTimer() async* {
    for (int i = 10; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  @override
  void initState() {
    super.initState();
    _timerStream = countdownTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Зворотний відлік')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1E2E), Color(0xFF2A2A40)],
          ),
        ),
        child: Center(
          child: StreamBuilder<int>(
            stream: _timerStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Помилка таймера', style: TextStyle(color: Colors.red, fontSize: 24));
              }
              if (snapshot.hasData) {
                final seconds = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      seconds > 0 ? '$seconds' : 'Таймер завершено!',
                      style: TextStyle(
                        fontSize: seconds > 0 ? 80 : 32,
                        fontWeight: FontWeight.bold,
                        color: seconds > 0 ? Colors.tealAccent : Colors.greenAccent,
                      ),
                    ),
                    if (seconds == 0)
                      const Icon(Icons.check_circle, size: 100, color: Colors.greenAccent),
                  ],
                );
              }
              return const CircularProgressIndicator(color: Colors.teal);
            },
          ),
        ),
      ),
    );
  }
}