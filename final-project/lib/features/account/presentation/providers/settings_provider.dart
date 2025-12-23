import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/account/domain/usecases/get_settings.dart';
import 'package:news_app/features/account/domain/usecases/save_settings.dart';

/// Провайдер для управління налаштуваннями (тема, мова).
/// Змінює UI (тема, мова) і зберігає/завантажує дані з Firestore.
class SettingsProvider extends ChangeNotifier {
  final GetSettings getSettings;
  final SaveSettings saveSettings;

  SettingsProvider({required this.getSettings, required this.saveSettings});

  // Початкові значення
  ThemeMode _themeMode = ThemeMode.system; // системна тема за замовчуванням
  Locale _locale = const Locale('uk');     // українська за замовчуванням

  // Геттери для доступу з UI
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  // Поточний користувач (з Firebase Auth)
  User? get currentUser => FirebaseAuth.instance.currentUser;

  /// Завантажує налаштування з Firestore після входу
  Future<void> loadSettings() async {
    if (currentUser == null) return;

    final result = await getSettings();
    result.fold(
          (_) {}, // помилка — нічого не робимо
          (data) {
        // Оновлюємо локальні змінні
        _themeMode = data['theme'] == 'dark' ? ThemeMode.dark : ThemeMode.light;
        _locale = Locale(data['lang'] ?? 'uk');
        notifyListeners(); // сповіщаємо UI про зміни
      },
    );
  }

  /// Змінює тему та зберігає в Firestore
  Future<void> changeTheme(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    // Зберігаємо тільки змінене поле
    await saveSettings({'theme': mode == ThemeMode.dark ? 'dark' : 'light'});
  }

  /// Змінює мову та зберігає
  Future<void> changeLocale(Locale newLocale) async {
    _locale = newLocale;
    notifyListeners();
    await saveSettings({'lang': newLocale.languageCode});
  }

  /// Авторизація (дублюється з AuthProvider — можна оптимізувати)
  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    await loadSettings();
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    await loadSettings();
    notifyListeners();
  }

  /// Вихід з акаунту
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    // Скидаємо до дефолтних значень
    _themeMode = ThemeMode.system;
    _locale = const Locale('uk');
    notifyListeners();
  }

/// Пояснення:
/// - Provider для стану (тема, мова)
/// - Змінює UI через notifyListeners()
/// - Зберігає/завантажує з Firestore
}