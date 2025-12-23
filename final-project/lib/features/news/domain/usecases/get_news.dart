import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

/// Use case для отримання новин.
class GetNews {
  final NewsRepository repository;

  GetNews(this.repository);

  Future<Either<Failure, List<ArticleModel>>> call(
      String country, {
        String category = 'general',
        int page = 1,
      }) async {
    return await repository.getNews(country, category: category, page: page);
  }
}