enum DocumentType {
  dni,
  passport;

  String get value {
    switch (this) {
      case DocumentType.dni:
        return 'identifier';
      case DocumentType.passport:
        return 'passport';
    }
  }

  static List<String> get stringValues =>
      DocumentType.values.map((e) => e.value).toList();
}
