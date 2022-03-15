enum LanguageName {
  eng,
  hun,
  por,
  deu,
  rus,
  chi,
  spa,
  ita,
  nld,
  pol,
  ces,
  jpn,
  swe,
  fin,
  arb,
  tur,
  ben,
  hin,
  kor,
  tha,
  fra
}

LanguageName languageNameFromString(String value) =>
    LanguageName.values.firstWhere((element) => element.name == value);

extension LanguageNameExtension on LanguageName {
  String get humanReadable {
    switch (this) {
      case LanguageName.eng:
        return "English";
      case LanguageName.hun:
        return "Hungarian";
      case LanguageName.por:
        return "Portuguese";
      case LanguageName.deu:
        return "German";
      case LanguageName.rus:
        return "Russian";
      case LanguageName.chi:
        return "Chinese";
      case LanguageName.spa:
        return "Spanish";
      case LanguageName.ita:
        return "Italian";
      case LanguageName.nld:
        return "Dutch";
      case LanguageName.pol:
        return "Polish";
      case LanguageName.ces:
        return "Czech";
      case LanguageName.jpn:
        return "Japanese";
      case LanguageName.swe:
        return "Swedish";
      case LanguageName.fin:
        return "Finnish";
      case LanguageName.arb:
        return "Arabic";
      case LanguageName.tur:
        return "Turkish";
      case LanguageName.ben:
        return "Bengali";
      case LanguageName.hin:
        return "Hindi";
      case LanguageName.kor:
        return "Korean";
      case LanguageName.tha:
        return "Thai";
      case LanguageName.fra:
        return "French";
      default:
        return "Not found";
    }
  }
}
