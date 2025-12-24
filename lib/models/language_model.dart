class Language {
  final String code;
  final String name;
  final String flag;

  Language({
    required this.code,
    required this.name,
    required this.flag
  });

  // Default language (English)
  static Language defaultLanguage = Language(code: 'en', name: 'English', flag: '🇺🇸');

  // Static list of supported languages
  static List<Language> languages = [
    Language(code: 'ar', name: 'Arabic', flag: '🇸🇦'),
    Language(code: 'zh', name: 'Chinese', flag: '🇨🇳'),
    Language(code: 'en', name: 'English', flag: '🇺🇸'),
    Language(code: 'de', name: 'Deutsch', flag: '🇩🇪'),
    Language(code: 'he', name: 'Hebrew', flag: '🇮🇱'),
    Language(code: 'es', name: 'Español', flag: '🇪🇸'),
  ];
}
