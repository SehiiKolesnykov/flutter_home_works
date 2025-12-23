import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/usecases/get_news.dart';

enum NewsStatus { initial, loading, success, error, loadingMore }

/// Провайдер стану новин.
class NewsProvider extends ChangeNotifier {
  final GetNews getNews;

  NewsProvider({required this.getNews});

  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;

  NewsStatus _status = NewsStatus.initial;
  NewsStatus get status => _status;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _country = 'ua';
  String get country => _country;

  String _category = 'general';
  String get category => _category;

  int _page = 1;
  bool hasMore = true;

  final List<String> countries = ['ua', 'us', 'gb', 'fr', 'de'];

  /// Завантажує новини (перший виклик або пагінація)
  Future<void> fetchNews({bool isRefresh = false}) async {
    if (_status == NewsStatus.loading || _status == NewsStatus.loadingMore) return;

    if (isRefresh) {
      _page = 1;
      _articles = [];
      hasMore = true;
    }

    if (!hasMore) return;

    _status = _page == 1 ? NewsStatus.loading : NewsStatus.loadingMore;
    _errorMessage = '';
    notifyListeners();

    final result = await getNews(_country, category: _category, page: _page);
    result.fold(
          (failure) {
        _status = NewsStatus.error;
        _errorMessage = failure.message;
      },
          (newArticles) {
        if (newArticles.isEmpty) {
          hasMore = false;
        } else {
          _articles.addAll(newArticles);
          _page++;
        }
        _status = NewsStatus.success;
      },
    );
    notifyListeners();
  }

  void changeCountry(String newCountry) {
    _country = newCountry;
    fetchNews(isRefresh: true);
  }

  void changeCategory(String newCategory) {
    _category = newCategory;
    fetchNews(isRefresh: true);
  }

/// Пояснення:
/// - Управляє станом списку новин
/// - Підтримує пагінацію та оновлення
}