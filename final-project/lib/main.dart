import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/app/app.dart';
import 'package:news_app/app/di/injector.dart';
import 'package:news_app/features/auth/presentation/screens/login_screen.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/l10n/app_localizations.dart';


void main() async {
  // Забезпечуємо, щоб Flutter міг працювати з Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Ініціалізуємо Firebase з налаштуваннями для поточної платформи (Android/iOS/web)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Ініціалізуємо Hive — локальну базу даних для кешування
  await Hive.initFlutter();

  // Реєструємо адаптер для моделі ArticleModel (потрібно для Hive)
  Hive.registerAdapter(ArticleModelAdapter());

  // Відкриваємо бокс (аналог таблиці) для кешу новин
  await Hive.openBox('news_cache');

  // Ініціалізуємо Dependency Injection (GetIt)
  await init();

  // Запускаємо кореневий віджет — AuthWrapper
  runApp(const AuthWrapper());
}

/// Віджет-обгортка, яка перевіряє стан авторизації.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Слухаємо зміни стану авторизації від Firebase Auth
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Поки чекаємо відповіді від Firebase — показуємо лоадер
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        // Якщо користувач авторизований — запускаємо основний додаток
        if (snapshot.hasData) {
          return const MyApp();
        }
        // Якщо не авторизований — показуємо екран логіну
        else {
          return const LoginApp();
        }
      },
    );
  }
}

/// Окремий MaterialApp тільки для екрану логіну.
/// Він мінімальний, щоб не завантажувати провайдери до входу.
/// Це оптимізує швидкість запуску.
class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Вимикаємо банер "DEBUG" у верхньому правому куті
      debugShowCheckedModeBanner: false,
      // Підтримка локалізації (українська/англійська) — навіть на екрані логіну
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // Домашній екран — логін
      home: const LoginScreen(),
    );
  }
}