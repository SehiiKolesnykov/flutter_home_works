import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:news_app/core/widgets/app_button.dart';
import 'package:news_app/features/account/presentation/providers/settings_provider.dart';

/// Екран налаштувань (тема, мова, вихід).
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    // Отримуємо провайдер (слухаємо зміни)
    final provider = Provider.of<SettingsProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.account)),
      body: ListView(
        padding: EdgeInsets.all(4.w),
        children: [
          // Перемикач теми
          ListTile(
            title: Text(l10n.theme),
            trailing: Switch(
              value: provider.themeMode == ThemeMode.dark,
              onChanged: (val) => provider.changeTheme(val ? ThemeMode.dark : ThemeMode.light),
            ),
          ),
          // Вибір мови
          ListTile(
            title: Text(l10n.language),
            trailing: DropdownButton<Locale>(
              value: provider.locale,
              items: [
                DropdownMenuItem(value: const Locale('uk'), child: Text('Українська')),
                DropdownMenuItem(value: const Locale('en'), child: Text('English')),
              ],
              onChanged: (val) => provider.changeLocale(val!),
            ),
          ),
          SizedBox(height: 2.h),
          // Кнопка збереження
          AppButton(
            text: l10n.saveSettings,
            onPressed: () => provider.saveSettings({
              'theme': provider.themeMode == ThemeMode.dark ? 'dark' : 'light',
              'lang': provider.locale.languageCode,
            }),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 2.h),
        child: AppButton(
          text: l10n.signOut,
          onPressed: () async {
            await provider.signOut();
            // Після виходу автоматично йдемо на LoginScreen (AuthWrapper)
          },
        ),
      ),
    );
  }
}

/// Пояснення:
/// - Використовує Provider для реактивності
/// - Зміни теми/мови застосовуються одразу