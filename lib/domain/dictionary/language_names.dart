enum LanguageName {
  eng, hun
}

LanguageName languageNameFromString(String value) {
  switch (value) {
    case "eng":
      return LanguageName.eng;
    case "hun":
      return LanguageName.hun;
    default:
      return LanguageName.eng;
  }
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

  String get humanReadable {
    switch (this) {
      case LanguageName.eng:
        return "English";
      case LanguageName.hun:
        return "Hungarian";
      default:
        return "LanguageName";
    }
  }
}