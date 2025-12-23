import 'package:http/http.dart' as http;

/// Простий клієнт для HTTP-запитів.
class HttpClient {
  /// Виконує GET-запит
  Future<http.Response> get(String url) async {
    // Парсимо рядок URL у Uri
    return await http.get(Uri.parse(url));
  }

/// Пояснення:
/// - Це базовий клас, який використовується в NewsRemoteDataSourceImpl
}