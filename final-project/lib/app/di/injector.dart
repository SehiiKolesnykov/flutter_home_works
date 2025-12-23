import 'package:get_it/get_it.dart';
import 'package:news_app/core/network/http_client.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/account/presentation/providers/settings_provider.dart';
import 'package:news_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:news_app/features/news/data/datasources/news_local_datasource.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/usecases/get_news.dart';
import 'package:news_app/features/account/data/datasources/settings_datasource.dart';
import 'package:news_app/features/account/data/repositories/settings_repository_impl.dart';
import 'package:news_app/features/account/domain/repositories/settings_repository.dart';
import 'package:news_app/features/account/domain/usecases/get_settings.dart';
import 'package:news_app/features/account/domain/usecases/save_settings.dart';
import 'package:news_app/features/news/presentation/providers/news_provider.dart';
import 'package:news_app/features/saved/presentation/providers/saved_provider.dart';

/// Глобальний екземпляр GetIt для Dependency Injection
final injector = GetIt.instance;

/// Функція ініціалізації всіх залежностей.
/// Реєструємо singleton (один екземпляр на весь додаток)
Future<void> init() async {
  // Core — базові сервіси
  // HttpClient для запитів до API
  injector.registerLazySingleton(() => HttpClient());
  // Перевірка інтернету
  injector.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // News Feature
  injector.registerLazySingleton<NewsRemoteDataSourceImpl>(
        () => NewsRemoteDataSourceImpl(client: injector()),
  );
  injector.registerLazySingleton<NewsLocalDataSourceImpl>(
        () => NewsLocalDataSourceImpl(),
  );
  injector.registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(
      remoteDataSource: injector(),
      localDataSource: injector(),
      networkInfo: injector(),
    ),
  );
  // Use case для отримання новин
  injector.registerLazySingleton(() => GetNews(injector()));
  // Провайдер для UI новин
  injector.registerLazySingleton(() => NewsProvider(getNews: injector()));

  // Account Feature
  injector.registerLazySingleton<SettingsDataSourceImpl>(
        () => SettingsDataSourceImpl(),
  );
  injector.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(injector()),
  );
  injector.registerLazySingleton(() => GetSettings(injector()));
  injector.registerLazySingleton(() => SaveSettings(injector()));

  injector.registerLazySingleton(() => SettingsProvider(
    getSettings: injector(),
    saveSettings: injector(),
  ));

  injector.registerLazySingleton(() => SavedProvider());

  // Auth Feature
  injector.registerLazySingleton(() => AuthProvider(
    settingsProvider: injector<SettingsProvider>(),
    savedProvider: injector<SavedProvider>(),
  ));

  print('DI initialized successfully');
}