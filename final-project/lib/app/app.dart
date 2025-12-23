import 'package:flutter/material.dart';
import 'package:news_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:news_app/app/di/injector.dart';
import 'package:news_app/app/router/app_router.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/features/account/presentation/providers/settings_provider.dart';
import 'package:news_app/features/news/presentation/providers/news_provider.dart';
import 'package:news_app/features/saved/presentation/providers/saved_provider.dart';

/// Кореневий віджет після успішного входу.
/// Тут налаштовується весь UI: теми, провайдери, роутер, локалізація.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      // Sizer робить дизайн адаптивним (розміри в % від екрану)
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          // Реєструємо всі провайдери для управління станом
          providers: [
            // Провайдер для новин (залежить від use case GetNews)
            ChangeNotifierProvider(
              create: (_) => NewsProvider(getNews: injector()),
            ),

            // Провайдер для налаштувань (тема, мова)
            ChangeNotifierProvider(
              create: (_) => SettingsProvider(
                getSettings: injector(),
                saveSettings: injector(),
              ),
            ),

            // Провайдер для збережених статей
            ChangeNotifierProvider(create: (_) => SavedProvider()),

            // Провайдер для авторизації (інжектуємо через GetIt)
            ChangeNotifierProvider(create: (_) => injector<AuthProvider>()),
          ],
          child: Consumer<SettingsProvider>(
            // Consumer слухає зміни в SettingsProvider
            builder: (context, settingsProvider, child) {
              // Якщо користувач є (авторизований) — завантажуємо його налаштування з Firestore
              if (settingsProvider.currentUser != null) {
                settingsProvider.loadSettings();
              }

              // Основний MaterialApp з роутером
              return MaterialApp.router(
                title: 'News App',
                // Світла та темна теми
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                // Тема береться з налаштувань користувача
                themeMode: settingsProvider.themeMode,
                // Мова теж з налаштувань
                locale: settingsProvider.locale,
                // Локалізація (українська/англійська)
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                // Роутер для навігації (go_router)
                routerConfig: AppRouter.router,
              );
            },
          ),
        );
      },
    );
  }
}