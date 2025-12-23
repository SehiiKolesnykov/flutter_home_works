import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app/app/di/injector.dart';
import 'package:news_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:news_app/l10n/app_localizations.dart';

/// Екран логіну/реєстрації.
/// Використовує красивий фон з газетою, блюр, сегментовані кнопки та валідацію.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Ключ для валідації форми
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Режим: true = вхід, false = реєстрація
  bool _isLogin = true;
  // Запам'ятати мене (зараз не використовується, можна додати)
  bool _rememberMe = false;

  // Поточна мова на екрані логіну (можна змінити до входу)
  Locale _currentLocale = const Locale('uk');

  // Регулярки для валідації
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{6,}$');

  @override
  Widget build(BuildContext context) {
    // Тимчасово перевизначаємо локалізацію для екрану (щоб dropdown працював)
    return Localizations.override(
      context: context,
      locale: _currentLocale,
      delegates: AppLocalizations.localizationsDelegates,
      child: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context)!;
          // Отримуємо провайдер через GetIt (DI)
          final authProvider = injector<AuthProvider>();

          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                // Фонова картинка
                Image.asset(
                  'assets/images/newspaper.jpg',
                  fit: BoxFit.cover,
                ),
                // Напівпрозорий затемнювач
                Container(
                  color: Colors.black.withValues(alpha: 0.4),
                ),
                // Блюр-ефект
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 1),
                  child: Container(color: Colors.transparent),
                ),

                // Основний контент
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: _buildContent(context, l10n, authProvider),
                  ),
                ),

                // Лоадер поверх усього
                ValueListenableBuilder<bool>(
                  valueListenable: authProvider.isLoadingNotifier,
                  builder: (context, isLoading, child) {
                    return isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Будує основний контент екрану
  Widget _buildContent(BuildContext context, AppLocalizations l10n, AuthProvider authProvider) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Назва додатку
          Text(
            l10n.appName,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black.withValues(alpha: 0.5),
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Вибір мови (до входу)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<Locale>(
                value: _currentLocale,
                underline: const SizedBox(),
                icon: const Icon(Icons.language),
                items: const [
                  DropdownMenuItem(
                    value: Locale('uk'),
                    child: Text('Українська', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  DropdownMenuItem(
                    value: Locale('en'),
                    child: Text('English', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ],
                onChanged: (locale) {
                  if (locale == null) return;
                  setState(() => _currentLocale = locale);
                },
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Сегментовані кнопки: Вхід / Реєстрація
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(value: true, label: Text(l10n.login)),
              ButtonSegment(value: false, label: Text(l10n.register)),
            ],
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                  if (states.contains(MaterialState.selected)) {
                    return Theme.of(context).primaryColor.withValues(alpha: 0.8);
                  }
                  return Colors.white.withValues(alpha: 0.25);
                },
              ),
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => Colors.white,
              ),
            ),
            selected: {_isLogin},
            showSelectedIcon: false,
            onSelectionChanged: (v) {
              setState(() => _isLogin = v.first);
            },
          ),
          const SizedBox(height: 40),

          // Форма з полями
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 12, offset: const Offset(0, 6)),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: l10n.email),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return l10n.field_required;
                      if (!_emailRegex.hasMatch(v.trim())) return l10n.invalid_email;
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: l10n.password),
                    obscureText: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) return l10n.field_required;
                      if (!_passwordRegex.hasMatch(v)) return l10n.invalid_password;
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),

          // Повідомлення про помилку
          if (authProvider.errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                _getAuthErrorMessage(l10n, authProvider.errorMessage),
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 20),

          // Запам'ятати мене (можна використати для auto-login)
          if (_isLogin)
            CheckboxListTile(
              title: Text(
                l10n.remember_me,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
              ),
              value: _rememberMe,
              checkColor: Colors.white,
              onChanged: (v) => setState(() => _rememberMe = v ?? false),
            ),
          const SizedBox(height: 20),

          // Кнопка "Увійти" / "Зареєструватися"
          ElevatedButton(
            onPressed: () => _handleAuth(l10n, authProvider),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              _isLogin ? l10n.login : l10n.register,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// Обробка натискання кнопки входу/реєстрації
  Future<void> _handleAuth(AppLocalizations l10n, AuthProvider authProvider) async {
    if (!_formKey.currentState!.validate()) return;

    authProvider.clearError();

    try {
      if (_isLogin) {
        await authProvider.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        await authProvider.signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }
    } finally {
      // Тут можна додати додаткову логіку після спроби (наприклад, очищення полів)
    }
  }

  /// Перетворює ключ помилки на перекладений текст
  String _getAuthErrorMessage(AppLocalizations l10n, String errorKey) {
    switch (errorKey) {
      case 'email_already_in_use':
        return l10n.email_already_in_use;
      case 'user_not_found':
        return l10n.user_not_found;
      case 'wrong_password':
        return l10n.wrong_password;
      case 'invalid_email':
        return l10n.invalid_email;
      case 'invalid_password':
        return l10n.invalid_password;
      default:
        return l10n.auth_error;
    }
  }

/// Пояснення:
/// - Екран повністю самостійний (не залежить від MyApp)
/// - Локалізація override дозволяє змінювати мову до входу
/// - Красивий дизайн з блюром та фоном
}