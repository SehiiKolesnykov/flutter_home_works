import 'package:go_router/go_router.dart';
import 'package:news_app/app/widgets/bottom_nav_screen.dart';
import 'package:news_app/features/news/presentation/providers/news_provider.dart';
import 'package:news_app/features/news/presentation/screens/news_detail_screen.dart';
import 'package:provider/provider.dart';

/// Клас для налаштування маршрутів за допомогою go_router.
/// Це дозволяє використовувати URL-подібну навігацію.
class AppRouter {
  // Статичний роутер — доступний всюди
  static final router = GoRouter(
    routes: [
      // Головний екран з нижньою навігацією
      GoRoute(
        path: '/',
        builder: (context, state) => const BottomNavScreen(),
      ),
      // Детальний екран новини
      // :url — динамічний параметр (кодований URL статті)
      GoRoute(
        path: '/news_detail/:url',
        builder: (context, state) {
          // Отримуємо закодований URL з параметра
          final encodedUrl = state.pathParameters['url']!;
          // Розкодовуємо його
          final url = Uri.decodeComponent(encodedUrl);
          // Беремо провайдер (не слухаємо зміни, бо тільки читання)
          final provider = Provider.of<NewsProvider>(context, listen: false);
          // Шукаємо статтю за URL
          final article = provider.articles.firstWhere((a) => a.url == url);
          return NewsDetailScreen(article: article);
        },
      ),
    ],
  );
}