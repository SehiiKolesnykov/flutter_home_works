import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/account/domain/repositories/settings_repository.dart';

/// Use case для збереження налаштувань.
class SaveSettings {
  final SettingsRepository repository;

  SaveSettings(this.repository);

  Future<Either<Failure, void>> call(Map<String, dynamic> settings) async {
    return await repository.saveSettings(settings);
  }
}

/// Пояснення: аналогічно GetSettings — чистий проксі