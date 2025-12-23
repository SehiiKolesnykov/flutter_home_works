// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'Додаток Новин';

  @override
  String get news => 'Новини';

  @override
  String get account => 'Акаунт';

  @override
  String get general => 'Загальні';

  @override
  String get business => 'Бізнес';

  @override
  String get entertainment => 'Розваги';

  @override
  String get health => 'Здоров\'я';

  @override
  String get science => 'Наука';

  @override
  String get sports => 'Спорт';

  @override
  String get technology => 'Технології';

  @override
  String get login => 'Увійти';

  @override
  String get register => 'Зареєструватися';

  @override
  String get email => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get remember_me => 'Залишатися в системі';

  @override
  String get invalid_email => 'Невірний email';

  @override
  String get invalid_password =>
      'Пароль мінімум 6 символів, з літерою та цифрою';

  @override
  String get ukrainian => 'Українська';

  @override
  String get english => 'English';

  @override
  String get field_required => 'Поле обов\'язкове';

  @override
  String get email_already_in_use => 'Цей Email вже використовується';

  @override
  String get user_not_found => 'Користувач не знайдений';

  @override
  String get wrong_password => 'Невірний пароль';

  @override
  String get auth_error => 'Помилка авторизації';

  @override
  String get tryAgain => 'Повторити спробу';

  @override
  String get savedNews => 'Збережене';

  @override
  String get noSavedNews => 'Немає збережених новин';

  @override
  String get category => 'Категорія';

  @override
  String get theme => 'Тема';

  @override
  String get language => 'Мова';

  @override
  String get saveSettings => 'Зберегти налаштування';

  @override
  String get signOut => 'Вийти';
}
