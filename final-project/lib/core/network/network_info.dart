import 'package:connectivity_plus/connectivity_plus.dart';

/// Абстракція для перевірки наявності інтернету.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Реалізація перевірки підключення через connectivity_plus
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // Отримуємо поточний стан підключення
    final connectivityResult = await Connectivity().checkConnectivity();
    // Якщо немає жодного типу підключення — немає інтернету
    return connectivityResult != ConnectivityResult.none;
  }

/// Пояснення:
/// - Використовується в NewsRepositoryImpl для вибору між remote та local
}