import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/screens/news_list_screen.dart';
import 'package:news_app/features/saved/presentation/screens/saved_news_screen.dart';
import 'package:news_app/features/account/presentation/screens/account_screen.dart';
import 'package:news_app/l10n/app_localizations.dart';

/// Головний екран з нижньою навігацією.
/// Використовує IndexedStack, щоб зберігати стан вкладок (не перебудову'ється при перемиканні).
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  // Поточний індекс вкладки
  int _selectedIndex = 0;

  // Список екранів вкладок (статичний, не перебудовується)
  static const List<Widget> _screens = [
    NewsListScreen(),         // 0 — Новини
    SavedNewsScreen(),        // 1 — Збережене
    AccountScreen(),          // 2 — Акаунт
  ];

  @override
  Widget build(BuildContext context) {
    // Локалізація для міток
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      // IndexedStack зберігає стан усіх вкладок (наприклад, позицію скролу в новинах)
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      // Нижня панель навігації
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.article), label: l10n.news),
          BottomNavigationBarItem(icon: const Icon(Icons.bookmark_border), label: l10n.savedNews),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: l10n.account),
        ],
        currentIndex: _selectedIndex,
        // При тапі змінюємо індекс
        onTap: (index) => setState(() => _selectedIndex = index),
        // Колір для вибраного пункту
        selectedItemColor: Theme.of(context).primaryColor,
        // Колір для невибраних
        unselectedItemColor: Colors.grey.shade500,
      ),
    );
  }
}