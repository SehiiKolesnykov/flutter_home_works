import 'dart:math';

class ChatBotService {
  final Random _random = Random();

  Future<String> getResponse(String question) async {
    final lower = question.toLowerCase();

    if (lower.contains('яка погода')) {
      await Future.delayed(const Duration(seconds: 5));
      final temp = _random.nextInt(30) - 5;
      return 'Зараз погода: $temp°C';
    }

    final delay = 2 + _random.nextInt(3);
    await Future.delayed(Duration(seconds: delay));

    if (lower.contains('погано')) {
      throw Exception('Щось пішло не так! Спробуйте ще раз.');
    } else if (lower.contains('добре')) {
      return 'Я радий, що вам подобається!';
    } else {
      return 'Цікаве питання! Ось моя відповідь на "$question"';
    }
  }
}