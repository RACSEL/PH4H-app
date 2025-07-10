enum LanguageType {
  en,
  es;

  String get value {
    switch (this) {
      case LanguageType.en:
        return 'English';
      case LanguageType.es:
        return 'Español';
    }
  }

  static List<String> get stringValues =>
      LanguageType.values.map((e) => e.value).toList();
}
