import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

/// Абстрактний репозиторій для новин.
abstract class NewsRepository {
  Future<Either<Failure, List<ArticleModel>>> getNews(
      String country, {
        String category = 'general',
        int page = 1,
      });
}