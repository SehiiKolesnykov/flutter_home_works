import 'package:flutter/material.dart';
import 'package:news_app/core/utils/date_utils.dart';
import 'package:news_app/features/news/presentation/screens/news_detail_screen.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:news_app/core/widgets/app_button.dart';
import 'package:news_app/core/widgets/shimmer_skeleton.dart';
import 'package:news_app/features/news/presentation/providers/news_provider.dart';
import 'package:news_app/features/saved/presentation/providers/saved_provider.dart';

/// Головний екран списку новин.
/// Підтримує вибір країни/категорії, пагінацію, pull-to-refresh та збереження.
class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  // Контролер для скролу (для пагінації)
  final ScrollController _scrollController = ScrollController();
  bool _isFetching = false; // Захист від подвійного завантаження

  @override
  void initState() {
    super.initState();
    // Перше завантаження після побудови віджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialNews();
    });

    // Слухаємо скрол для підвантаження більше новин
    _scrollController.addListener(() {
      if (_isFetching || !_hasMore()) return;

      // Якщо скролимо до кінця
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300) {
        _fetchMoreNews();
      }
    });
  }

  Future<void> _fetchInitialNews() async {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    provider.fetchNews(isRefresh: true);
  }

  Future<void> _fetchMoreNews() async {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    _isFetching = true;
    await provider.fetchNews();
    _isFetching = false;
  }

  bool _hasMore() {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    return provider.hasMore;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    // Список категорій з локалізацією
    final categories = [
      {'key': 'general', 'name': l10n.general, 'icon': Icons.public},
      {'key': 'business', 'name': l10n.business, 'icon': Icons.business},
      {'key': 'entertainment', 'name': l10n.entertainment, 'icon': Icons.movie},
      {'key': 'health', 'name': l10n.health, 'icon': Icons.health_and_safety},
      {'key': 'science', 'name': l10n.science, 'icon': Icons.science},
      {'key': 'sports', 'name': l10n.sports, 'icon': Icons.sports_soccer},
      {'key': 'technology', 'name': l10n.technology, 'icon': Icons.computer},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.news),
        actions: [
          // Вибір країни
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: DropdownButton<String>(
              value: provider.country,
              items: provider.countries
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.toUpperCase())))
                  .toList(),
              onChanged: (value) => provider.changeCountry(value!),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Горизонтальний список категорій
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = provider.category == cat['key'];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: GestureDetector(
                    onTap: () => provider.changeCategory(cat['key'] as String),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: isSelected
                            ? [BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha: 0.5), blurRadius: 8)]
                            : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            cat['icon'] as IconData,
                            size: 20,
                            color: isSelected ? Colors.white : Colors.black54,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            cat['name'] as String,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Основний список новин
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                provider.fetchNews(isRefresh: true);
              },
              child: Builder(
                builder: (context) {
                  // Стан завантаження
                  if (provider.status == NewsStatus.loading) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (_, __) => const ShimmerSkeleton(),
                    );
                  }
                  // Помилка
                  else if (provider.status == NewsStatus.error) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline_rounded, size: 80.sp, color: Colors.redAccent),
                            SizedBox(height: 2.h),
                            Text(
                              provider.errorMessage,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.redAccent),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4.h),
                            AppButton(
                              text: l10n.tryAgain,
                              onPressed: () => provider.fetchNews(isRefresh: true),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  // Успішний список
                  else {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: provider.articles.length + (provider.status == NewsStatus.loadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        // Лоадер для пагінації
                        if (index == provider.articles.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final article = provider.articles[index];

                        return GestureDetector(
                          // Перехід до детального екрану
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(article: article),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                            height: 36.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                children: [
                                  // Зображення
                                  Positioned.fill(
                                    child: article.urlToImage.isNotEmpty
                                        ? Image.network(
                                      article.urlToImage,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: Colors.grey.shade300,
                                        child: Icon(Icons.broken_image, size: 50),
                                      ),
                                    )
                                        : Container(color: Colors.grey.shade300),
                                  ),
                                  // Градієнт + заголовок знизу
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 4.h),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.white.withValues(alpha: 0.2),
                                            Colors.white.withValues(alpha: 0.6),
                                            Colors.white,
                                          ],
                                        ),
                                      ),
                                      child: Text(
                                        article.title,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Дата знизу праворуч
                                  Positioned(
                                    bottom: 1.h,
                                    right: 4.w,
                                    child: Text(
                                      DateUtil.formatDate(article.publishedAt),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        shadows: [
                                          Shadow(blurRadius: 5, color: Colors.black.withValues(alpha: 0.8)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Кнопка збереження зверху праворуч
                                  Positioned(
                                    top: 1.h,
                                    right: 1.h,
                                    child: Consumer<SavedProvider>(
                                      builder: (context, savedProvider, child) {
                                        final isSaved = savedProvider.isSaved(article.id, article.url);
                                        return IconButton(
                                          icon: Icon(
                                            isSaved ? Icons.bookmark_added_outlined : Icons.bookmark_add_outlined,
                                            color: isSaved ? Colors.red : Colors.white,
                                            size: 32,
                                          ),
                                          onPressed: () => savedProvider.toggleSave(article),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}