import 'package:intl/intl.dart';

/// Утиліта для роботи з датами.
class DateUtil {
  /// Форматує дату з ISO-формату (з API) у локальний формат dd.MM.yyyy HH:mm
  static String formatDate(String dateString) {
    try {
      // Парсимо рядок у DateTime (UTC)
      final utcDate = DateTime.parse(dateString);

      // Переводимо в локальний час (враховує часовий пояс користувача)
      final localDate = utcDate.toLocal();

      // Форматуємо
      final formatter = DateFormat('dd.MM.yyyy HH:mm');
      return formatter.format(localDate);
    } catch (e) {
      // Якщо дата невалідна — повертаємо оригінальний рядок
      return dateString;
    }
  }
}