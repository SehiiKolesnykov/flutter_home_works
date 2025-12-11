import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class RealTimeDataScreen extends StatefulWidget {
  const RealTimeDataScreen({super.key});

  @override
  State<RealTimeDataScreen> createState() => _RealTimeDataScreenState();
}

class _RealTimeDataScreenState extends State<RealTimeDataScreen> {
  final StreamController<int> _controller = StreamController<int>();
  Timer? _timer;
  bool _isPaused = false;
  int _lastValue = 0;
  String _errorMessage = '';

  void _startStream() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (_isPaused) return;
      final random = Random();
      final value = random.nextInt(100) + 1;
      if (value > 90) {
        _controller.addError('Критична помилка! Значення: $value');
      } else {
        _controller.add(value);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startStream();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real-Time Дані')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1E2E), Color(0xFF2A2A40)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<int>(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    _errorMessage = snapshot.error.toString();
                    return Text('Помилка: $_errorMessage', style: const TextStyle(color: Colors.redAccent, fontSize: 20));
                  }
                  if (snapshot.hasData) {
                    _lastValue = snapshot.data!;
                    return Column(
                      children: [
                        const Icon(Icons.show_chart, size: 80, color: Colors.yellow),
                        const SizedBox(height: 20),
                        Text('Поточне значення', style: TextStyle(color: Colors.white70)),
                        Text('$_lastValue', style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.yellow)),
                      ],
                    );
                  }
                  return const Text('Очікування даних...', style: TextStyle(color: Colors.white70, fontSize: 18));
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => setState(() => _isPaused = !_isPaused),
                icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause, color: Colors.black,),
                label: Text(_isPaused ? 'Поновити' : 'Зупинити', style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}