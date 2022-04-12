import 'package:hive/hive.dart';

part 'language_names.g.dart';

@HiveType(typeId: 2)
enum LanguageName {
  @HiveField(0)
  eng,
  @HiveField(1)
  hun,
  @HiveField(2)
  por,
  @HiveField(3)
  deu,
  @HiveField(4)
  rus,
  @HiveField(5)
  chi,
  @HiveField(6)
  spa,
  @HiveField(7)
  ita,
  @HiveField(8)
  nld,
  @HiveField(9)
  pol,
  @HiveField(10)
  ces,
  @HiveField(11)
  jpn,
  @HiveField(12)
  swe,
  @HiveField(13)
  fin,
  @HiveField(14)
  arb,
  @HiveField(15)
  tur,
  @HiveField(16)
  ben,
  @HiveField(17)
  hin,
  @HiveField(18)
  kor,
  @HiveField(19)
  tha,
  @HiveField(20)
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
