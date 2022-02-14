enum LanguageName {
  eng, hun
}

extension LanguageNameExtension on LanguageName {
  String get value {
    switch (this) {
      case LanguageName.eng:
        return "eng";
      case LanguageName.hun:
        return "hun";
      default:
        return "LanguageName";
    }
  }
}