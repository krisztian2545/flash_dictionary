import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:hive/hive.dart';

part 'word_with_params.g.dart';

@HiveType(typeId: 1)
class WordWithParams {
  WordWithParams(this.word, this.fromLanguage, this.toLanguage);

  @HiveField(0)
  String word;

  @HiveField(1)
  LanguageName fromLanguage;

  @HiveField(2)
  LanguageName toLanguage;

  @override
  bool operator ==(Object other) =>
      other is WordWithParams &&
      other.runtimeType == runtimeType &&
      other.word == word &&
      other.fromLanguage == fromLanguage &&
      other.toLanguage == toLanguage;

  @override
  int get hashCode => (word + fromLanguage.name + toLanguage.name).hashCode;
}
