import 'package:hive/hive.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

/// Локальне джерело даних для новин (кешування через Hive).
class NewsLocalDataSourceImpl {
  // Бокс  для зберігання кешованих новин
  final _box = Hive.box('news_cache');

  /// Зберігає список новин для конкретної країни
  /// Ключ: 'news_ua', 'news_us' тощо
  Future<void> cacheNews(String country, List<ArticleModel> articles) async {
    await _box.put('news_$country', articles);
  }

  /// Повертає кешовані новини для країни
  /// Якщо немає — повертає порожній список
  List<ArticleModel> getCachedNews(String country) {
    return _box.get('news_$country', defaultValue: <ArticleModel>[]).cast<ArticleModel>();
  }

/// Пояснення:
/// - Використовується тільки для офлайн-режиму або як резерв
/// - Зберігає тільки першу сторінку (page=1), бо пагінація не кешується
}