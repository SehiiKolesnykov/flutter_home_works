import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';

/// Абстрактний репозиторій для налаштувань.
/// Визначає інтерфейс, який використовується в use cases та провайдерах.
abstract class SettingsRepository {
  /// Отримує налаштування
  Future<Either<Failure, Map<String, dynamic>>> getSettings();

  /// Зберігає налаштування
  Future<Either<Failure, void>> saveSettings(Map<String, dynamic> settings);
}

/// Пояснення:
/// - Clean Architecture: domain-шар не знає про реалізацію (Firestore/Hive)
/// - Це дозволяє легко замінити джерело даних (наприклад, на локальне)