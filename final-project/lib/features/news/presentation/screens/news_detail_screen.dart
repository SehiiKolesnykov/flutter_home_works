import 'package:flutter/material.dart';
import 'package:news_app/core/utils/date_utils.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/saved/presentation/providers/saved_provider.dart';
import 'package:news_app/features/news/presentation/providers/news_provider.dart';

/// Детальний екран статті.
/// Показує зображення, заголовок, опис, дату, категорію та кнопку збереження.
class NewsDetailScreen extends StatelessWidget {
  final ArticleModel article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Отримуємо провайдер для збереження статей
    final savedProvider = Provider.of<SavedProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      // Розширюємо тіло під AppBar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Кнопка "назад" у стилізованому колі
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        // Кнопка збереження
        actions: [
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ),
            onPressed: () => savedProvider.toggleSave(article),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Велике зображення зверху
            if (article.urlToImage.isNotEmpty)
              Image.network(
                article.urlToImage,
                width: double.infinity,
                height: 40.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 40.h,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.broken_image, size: 50),
                ),
              )
            else
              Container(
                height: 40.h,
                color: Colors.grey.shade300,
                child: Icon(Icons.image_not_supported, size: 50),
              ),

            // Заголовок
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Text(
                article.title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
            ),

            // Опис
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                article.description,
                style: TextStyle(
                  fontSize: 16.sp,
                  height: 1.5,
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Дата та категорія
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Дата: ${DateUtil.formatDate(article.publishedAt)}',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
                      ),
                      SizedBox(height: 0.5.h),
                      // Категорія беремо з NewsProvider (щоб показати актуальну)
                      Consumer<NewsProvider>(
                        builder: (context, newsProvider, child) {
                          return Text(
                            '${l10n.category}: ${newsProvider.category.toUpperCase()}',
                            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
                          );
                        },
                      ),
                    ],
                  ),
                  // Кнопка збереження з динамічною іконкою
                  IconButton(
                    icon: Icon(
                      savedProvider.isSaved(article.id, article.url)
                          ? Icons.bookmark_added_outlined
                          : Icons.bookmark_add_outlined,
                      color: savedProvider.isSaved(article.id, article.url) ? Colors.red : Colors.grey,
                      size: 32,
                    ),
                    onPressed: () => savedProvider.toggleSave(article),
                  ),
                ],
              ),
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

/// Пояснення:
/// - Екран простий і чистий, з адаптивними розмірами (sizer)
/// - Зображення кешується автоматично через Image.network
}