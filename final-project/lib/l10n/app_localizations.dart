import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk')
  ];

  /// No description provided for @appName.
  ///
  /// In uk, this message translates to:
  /// **'Додаток Новин'**
  String get appName;

  /// No description provided for @news.
  ///
  /// In uk, this message translates to:
  /// **'Новини'**
  String get news;

  /// No description provided for @account.
  ///
  /// In uk, this message translates to:
  /// **'Акаунт'**
  String get account;

  /// No description provided for @general.
  ///
  /// In uk, this message translates to:
  /// **'Загальні'**
  String get general;

  /// No description provided for @business.
  ///
  /// In uk, this message translates to:
  /// **'Бізнес'**
  String get business;

  /// No description provided for @entertainment.
  ///
  /// In uk, this message translates to:
  /// **'Розваги'**
  String get entertainment;

  /// No description provided for @health.
  ///
  /// In uk, this message translates to:
  /// **'Здоров\'я'**
  String get health;

  /// No description provided for @science.
  ///
  /// In uk, this message translates to:
  /// **'Наука'**
  String get science;

  /// No description provided for @sports.
  ///
  /// In uk, this message translates to:
  /// **'Спорт'**
  String get sports;

  /// No description provided for @technology.
  ///
  /// In uk, this message translates to:
  /// **'Технології'**
  String get technology;

  /// No description provided for @login.
  ///
  /// In uk, this message translates to:
  /// **'Увійти'**
  String get login;

  /// No description provided for @register.
  ///
  /// In uk, this message translates to:
  /// **'Зареєструватися'**
  String get register;

  /// No description provided for @email.
  ///
  /// In uk, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In uk, this message translates to:
  /// **'Пароль'**
  String get password;

  /// No description provided for @remember_me.
  ///
  /// In uk, this message translates to:
  /// **'Залишатися в системі'**
  String get remember_me;

  /// No description provided for @invalid_email.
  ///
  /// In uk, this message translates to:
  /// **'Невірний email'**
  String get invalid_email;

  /// No description provided for @invalid_password.
  ///
  /// In uk, this message translates to:
  /// **'Пароль мінімум 6 символів, з літерою та цифрою'**
  String get invalid_password;

  /// No description provided for @ukrainian.
  ///
  /// In uk, this message translates to:
  /// **'Українська'**
  String get ukrainian;

  /// No description provided for @english.
  ///
  /// In uk, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @field_required.
  ///
  /// In uk, this message translates to:
  /// **'Поле обов\'язкове'**
  String get field_required;

  /// No description provided for @email_already_in_use.
  ///
  /// In uk, this message translates to:
  /// **'Цей Email вже використовується'**
  String get email_already_in_use;

  /// No description provided for @user_not_found.
  ///
  /// In uk, this message translates to:
  /// **'Користувач не знайдений'**
  String get user_not_found;

  /// No description provided for @wrong_password.
  ///
  /// In uk, this message translates to:
  /// **'Невірний пароль'**
  String get wrong_password;

  /// No description provided for @auth_error.
  ///
  /// In uk, this message translates to:
  /// **'Помилка авторизації'**
  String get auth_error;

  /// No description provided for @tryAgain.
  ///
  /// In uk, this message translates to:
  /// **'Повторити спробу'**
  String get tryAgain;

  /// No description provided for @savedNews.
  ///
  /// In uk, this message translates to:
  /// **'Збережене'**
  String get savedNews;

  /// No description provided for @noSavedNews.
  ///
  /// In uk, this message translates to:
  /// **'Немає збережених новин'**
  String get noSavedNews;

  /// No description provided for @category.
  ///
  /// In uk, this message translates to:
  /// **'Категорія'**
  String get category;

  /// No description provided for @theme.
  ///
  /// In uk, this message translates to:
  /// **'Тема'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In uk, this message translates to:
  /// **'Мова'**
  String get language;

  /// No description provided for @saveSettings.
  ///
  /// In uk, this message translates to:
  /// **'Зберегти налаштування'**
  String get saveSettings;

  /// No description provided for @signOut.
  ///
  /// In uk, this message translates to:
  /// **'Вийти'**
  String get signOut;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
