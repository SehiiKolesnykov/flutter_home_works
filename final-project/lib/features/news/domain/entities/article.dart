/// Чиста сутність статті (без залежностей від Hive/JSON).
/// Використовується в domain-шарі.
class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

/// Пояснення:
/// - Зараз не використовується активно (є ArticleModel)
/// - Може бути корисним для тестів
}