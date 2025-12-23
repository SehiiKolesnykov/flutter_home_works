import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/account/presentation/providers/settings_provider.dart';
import 'package:news_app/features/saved/presentation/providers/saved_provider.dart';

/// Провайдер для управління авторизацією.
/// Відповідає за вхід, реєстрацію, обробку помилок та синхронізацію після входу.
class AuthProvider extends ChangeNotifier {
  // Залежності (інжектуються через GetIt)
  final SettingsProvider _settingsProvider;
  final SavedProvider _savedProvider;

  AuthProvider({
    required SettingsProvider settingsProvider,
    required SavedProvider savedProvider,
  })  : _settingsProvider = settingsProvider,
        _savedProvider = savedProvider;

  // Стан завантаження (для показу лоадера)
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Повідомлення про помилку (показується під формою)
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // ValueNotifier для швидкого оновлення лоадера (використовується в LoginScreen)
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  /// Вхід у систему
  Future<void> signIn(String email, String password) async {
    _setLoading(true); // Вмикаємо лоадер
    try {
      // Авторизація через Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      // Після успішного входу:
      await _settingsProvider.loadSettings(); // Завантажуємо тему/мову
      await _savedProvider.syncWithFirebase(); // Синхронізуємо збережені статті
    } on FirebaseAuthException catch (e) {
      // Обробка помилок Firebase
      _errorMessage = _mapAuthError(e.code);
    } catch (_) {
      _errorMessage = 'auth_error';
    }
    _setLoading(false); // Вимикаємо лоадер
  }

  /// Реєстрація нового користувача
  Future<void> signUp(String email, String password) async {
    _setLoading(true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await _settingsProvider.loadSettings();
      await _savedProvider.syncWithFirebase();
    } on FirebaseAuthException catch (e) {
      _errorMessage = _mapAuthError(e.code);
    } catch (_) {
      _errorMessage = 'auth_error';
    }
    _setLoading(false);
  }

  /// Перетворює код помилки Firebase на ключ для локалізації
  String _mapAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'email_already_in_use';
      case 'user-not-found':
        return 'user_not_found';
      case 'wrong-password':
        return 'wrong_password';
      case 'invalid-email':
        return 'invalid_email';
      case 'weak-password':
        return 'invalid_password';
      default:
        return 'auth_error';
    }
  }

  /// Внутрішній метод для зміни стану завантаження
  void _setLoading(bool value) {
    _isLoading = value;
    isLoadingNotifier.value = value;
    notifyListeners(); // Сповіщаємо UI
  }

  /// Очищає повідомлення про помилку
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

/// Пояснення:
/// - Провайдер відповідає тільки за логіку авторизації та синхронізації
}