import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

/// Провайдер для управління збереженими статтями.
/// Зберігає локально (Hive) + синхронізує з Firestore (якщо користувач авторизований).
class SavedProvider extends ChangeNotifier {
  late Box<ArticleModel> _savedBox; // Локальна база Hive
  List<ArticleModel> _savedArticles = []; // Кеш списку для швидкого доступу
  List<ArticleModel> get savedArticles => _savedArticles;

  SavedProvider() {
    _init(); // Ініціалізація при створенні провайдера
  }

  /// Ініціалізація Hive та синхронізація з Firestore
  Future<void> _init() async {
    _savedBox = await Hive.openBox<ArticleModel>('saved_news');
    _savedArticles = _savedBox.values.toList();
    await syncWithFirebase(); // Синхронізуємо з хмарою
    notifyListeners();
  }

  /// Перемикає стан збереження статті
  /// Якщо вже збережена — видаляє, інакше — додає
  Future<void> toggleSave(ArticleModel article) async {
    final user = FirebaseAuth.instance.currentUser;
    final key = article.id; // Унікальний ключ — ID статті

    if (_savedBox.containsKey(key)) {
      // Видаляємо з Hive
      await _savedBox.delete(key);
      _savedArticles.removeWhere((a) => a.id == key);

      // Якщо авторизований — видаляємо з Firestore
      if (user != null) {
        await _removeFromFirebase(user.uid, key);
      }
    } else {
      // Додаємо в Hive
      await _savedBox.put(key, article);
      _savedArticles.add(article);

      // Якщо авторизований — додаємо в Firestore
      if (user != null) {
        await _addToFirebase(user.uid, article);
      }
    }
    notifyListeners(); // Оновлюємо UI
  }

  /// Додає статтю в Firestore
  Future<void> _addToFirebase(String uid, ArticleModel article) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('saved_articles')
          .doc(article.id)
          .set(article.toJson());
    } catch (e) {
      print('Firestore save error: $e');
      // Покращення: можна показати помилку користувачу або retry
    }
  }

  /// Видаляє статтю з Firestore
  Future<void> _removeFromFirebase(String uid, String articleId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('saved_articles')
        .doc(articleId)
        .delete();
  }

  /// Перевіряє, чи стаття збережена
  /// Параметр fallbackUrl — на випадок, якщо ID відсутній
  bool isSaved(String? articleId, [String? fallbackUrl]) {
    final key = articleId ?? fallbackUrl ?? '';
    return _savedBox.containsKey(key);
  }

  /// Синхронізує локальні дані з Firestore
  /// Викликається при ініціалізації та після входу
  Future<void> syncWithFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('saved_articles')
        .get();

    final firebaseArticles = snapshot.docs.map((doc) {
      return ArticleModel.fromJson(doc.data());
    }).toList();

    // Очищаємо Hive і записуємо все з Firestore
    await _savedBox.clear();
    for (var article in firebaseArticles) {
      await _savedBox.put(article.id, article);
    }

    _savedArticles = _savedBox.values.toList();
    notifyListeners();
  }

/// Пояснення:
/// - Двошаровий кеш: Hive (швидкий локальний) + Firestore (синхронізація)
/// - syncWithFirebase() викликається в AuthProvider після входу
}