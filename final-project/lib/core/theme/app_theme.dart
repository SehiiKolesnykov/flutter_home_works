import 'package:flutter/material.dart';

/// Клас із визначенням світлої та темної теми.
/// Використовується в MyApp для themeMode.
class AppTheme {
  /// Світла тема
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,                // Основний колір (кнопки, акценти)
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.grey.shade100,          // Фон карток
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
    ),
    fontFamily: 'Roboto',                     // Шрифт за замовчуванням
  );

  /// Темна тема
  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue.shade700,
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.grey.shade900,
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
    ),
    fontFamily: 'Roboto',
  );

}