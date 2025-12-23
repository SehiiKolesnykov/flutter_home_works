import 'package:flutter/material.dart';
import 'package:news_app/core/utils/date_utils.dart';
import 'package:news_app/features/news/presentation/screens/news_detail_screen.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:news_app/features/saved/presentation/providers/saved_provider.dart';

/// Екран зі збереженими статтями.
/// Показує список збережених новин або повідомлення "немає збережених".
class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Отримуємо провайдер і слухаємо зміни (реактивний UI)
    final provider = Provider.of<SavedProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.savedNews),
      ),
      body: provider.savedArticles.isEmpty
      // Якщо немає збережених статей — показуємо гарне повідомлення
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Іконка закладки
            Icon(Icons.bookmark_border, size: 80.sp, color: Colors.grey),
            SizedBox(height: 2.h),
            Text(
              l10n.noSavedNews,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      )
      // Якщо є статті — показуємо список
          : ListView.builder(
        padding: EdgeInsets.all(2.w),
        itemCount: provider.savedArticles.length,
        itemBuilder: (context, index) {
          final article = provider.savedArticles[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 1.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: EdgeInsets.all(2.w),
              // Маленьке зображення зліва (якщо є)
              leading: article.urlToImage.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  article.urlToImage,
                  width: 20.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 20.w),
                ),
              )
                  : null,
              // Заголовок (2 рядки максимум)
              title: Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              // Дата публікації
              subtitle: Text(
                DateUtil.formatDate(article.publishedAt),
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
              // Кнопка видалення (toggleSave видаляє)
              trailing: IconButton(
                icon: const Icon(Icons.bookmark_added_outlined, color: Colors.red),
                onPressed: () => provider.toggleSave(article),
              ),
              // Перехід до детального екрану при тапі
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(article: article),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

/// Пояснення:
/// - Екран повністю реактивний завдяки Provider.of<SavedProvider>
/// - Використовує Card + ListTile для гарного вигляду
/// - Зображення кешується автоматично через Image.network
}