import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Реалізація джерела даних для налаштувань.
/// Працює безпосередньо з Firestore (хмарне сховище).
class SettingsDataSourceImpl {
  // Екземпляри Firestore та Auth (один на весь клас)
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /// Отримує налаштування користувача з Firestore.
  /// Повертає null, якщо користувач не авторизований.
  Future<Map<String, dynamic>?> getSettings() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    // Отримуємо документ користувача за UID
    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc.data();
  }

  /// Зберігає налаштування в Firestore.
  /// Використовує merge: true — не перезаписує весь документ, а тільки змінює вказані поля.
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Користувач не авторизований');

    await _firestore.collection('users').doc(user.uid).set(
      settings,
      SetOptions(merge: true),
    );
  }

/// Пояснення:
/// - Це data source — найнижчий рівень (без обробки помилок)
}