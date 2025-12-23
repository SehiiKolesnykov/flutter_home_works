import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/news/data/datasources/news_local_datasource.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

/// Реалізація репозиторію новин.
/// Вибирає між віддаленим та локальним джерелом залежно від інтернету.
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSourceImpl remoteDataSource;
  final NewsLocalDataSourceImpl localDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ArticleModel>>> getNews(
      String country, {
        String category = 'general',
        int page = 1,
      }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNews = await remoteDataSource.getNews(
          country,
          category: category,
          page: page,
        );
        // Кешуємо тільки першу сторінку
        if (page == 1) {
          await localDataSource.cacheNews(country, remoteNews);
        }
        return Right(remoteNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localNews = localDataSource.getCachedNews(country);
        return Right(localNews);
      } on Exception {
        return Left(CacheFailure());
      }
    }
  }

/// Пояснення:
/// - Clean Arch: репозиторій — єдиний вхід до даних
}