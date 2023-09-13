import 'app.export.dart';

class LocalizationService extends Translations {
  // Default locale
  static const locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('tr', 'TR');

  // Supported languages
  // Needs to be same order with locales
  static final languages = [
    'English',
    'Türkçe',
    '日本語',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('en', 'US'),
    const Locale('tr', 'TR'),
    const Locale('ja', 'JP'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': english, // lang/en_us.dart
        'tr_TR': turkish, // lang/tr_tr.dart
        'ja_JP': japanese, // lang/ja_jp.dart
      };

  Map<String, String> english = {
    'hello': 'Hello!',
  };
  Map<String, String> japanese = {
    'hello': '今日は!',
  };
  Map<String, String> turkish = {
    'hello': 'Merhaba!',
  };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < languages.length; i++) {
      if (lang == languages[i]) return locales[i];
    }
    return Get.locale;
  }
}
