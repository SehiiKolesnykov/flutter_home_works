import 'dart:convert';

import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/network/http_client.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

/// Віддалене джерело даних — API GNews.io
class NewsRemoteDataSourceImpl {
  final HttpClient client;

  // Конфігурація API
  static const _apiKey = 'aaad7ade52ba4599c21086b6f6d66a64';
  static const _baseUrl = 'https://gnews.io/api/v4/top-headlines';

  NewsRemoteDataSourceImpl({required this.client});

  /// Отримує новини з API
  /// Додатковий фільтр для України: тільки статті з кирилицею
  Future<List<ArticleModel>> getNews(
      String country, {
        String category = 'general',
        int page = 1,
      }) async {
    String url = '$_baseUrl?country=$country&category=$category&token=$_apiKey&page=$page';

    // Для України додаємо параметр мови
    if (country == 'ua') {
      url += '&lang=uk';
    }

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final articles = (json['articles'] as List)
          .map((e) => ArticleModel.fromJson(e))
          .toList();

      // Фільтр: видаляємо статті без кирилиці для ua
      if (country == 'ua') {
        articles.removeWhere((article) {
          final text = ('${article.title} ${article.description}').toLowerCase();
          return !text.contains(RegExp(r'[а-яіїєґ]'));
        });
      }

      return articles;
    } else {
      throw ServerException();
    }
  }

/// Пояснення:
/// - Викидає ServerException при помилці — обробляється в репозиторії
/// - Фільтр для ua потрібен, бо GNews іноді повертає англійські статті
}