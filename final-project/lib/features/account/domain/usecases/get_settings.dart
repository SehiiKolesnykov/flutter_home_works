import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/account/domain/repositories/settings_repository.dart';

/// Use case для отримання налаштувань.
/// Просто делегує виклик репозиторію.
class GetSettings {
  final SettingsRepository repository;

  GetSettings(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call() async {
    return await repository.getSettings();
  }
}

/// Пояснення:
/// - Use case — найчистіший шар (тільки бізнес-логіка)