import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  String _log = '';
  bool _isLoading = false;

  Future<void> _fetchData() async {
    setState(() {
      _log = '';
      _isLoading = true;
    });

    // Етап 1
    _addLog('Етап 1: Ініціалізація...');
    await Future.delayed(const Duration(seconds: 2));
    _addLog('Етап 1: Успішно!');

    // Етап 2
    _addLog('Етап 2: Запит до API...');
    final random = Random();
    if (random.nextDouble() < 0.1) {
      _addLog('Помилка на етапі 2!', isError: true);
      setState(() => _isLoading = false);
      return;
    }
    _addLog('Етап 2: Успішно!');

    // Етап 3
    _addLog('Етап 3: Обробка результату...');
    await Future.delayed(const Duration(seconds: 3));
    _addLog('Етап 3: Успішно!');
    _addLog('Всі етапи завершено успішно!', isSuccess: true);

    setState(() => _isLoading = false);
  }

  void _addLog(String text, {bool isError = false, bool isSuccess = false}) {
    setState(() {
      _log += '$text\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Багатoeтапний API')),
      body: Container(
        width: 100.w,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1E2E), Color(0xFF2A2A40)],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _fetchData,
              icon: const Icon(Icons.cloud_download),
              label: const Text('Запустити API'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            ),
            const SizedBox(height: 30),

            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: 92.w,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        _log.isEmpty ? 'Лог порожній' : _log,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.indigo,
                        strokeWidth: 4,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}