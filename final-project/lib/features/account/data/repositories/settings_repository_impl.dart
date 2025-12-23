import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/account/data/datasources/settings_datasource.dart';
import 'package:news_app/features/account/domain/repositories/settings_repository.dart';

/// Реалізація репозиторію для налаштувань.
/// Використовує dartz для функціональної обробки помилок (Either).
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDataSourceImpl dataSource;

  SettingsRepositoryImpl(this.dataSource);

  /// Отримує налаштування з data source.
  /// Якщо помилка — повертає ServerFailure.
  /// Якщо немає даних — повертає порожній Map.
  @override
  Future<Either<Failure, Map<String, dynamic>>> getSettings() async {
    try {
      final settings = await dataSource.getSettings();
      return Right(settings ?? {});
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  /// Зберігає налаштування.
  /// Успіх — Right(null), помилка — ServerFailure.
  @override
  Future<Either<Failure, void>> saveSettings(Map<String, dynamic> settings) async {
    try {
      await dataSource.saveSettings(settings);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

/// Пояснення:
/// - Це шар абстракції над data source
/// - Обробляє винятки → перетворює їх на Failure
}