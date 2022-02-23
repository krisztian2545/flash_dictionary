import 'package:flash_dictionary/domain/dictionary/language_names.dart';

enum CollectionType { translation, definition }

class CollectionDetails {
  CollectionDetails(
      {required this.name,
      required this.type,
      required this.fromLanguage,
      this.toLanguage});

  final String name;
  final CollectionType type;
  final LanguageName fromLanguage;
  final LanguageName? toLanguage;

  static CollectionDetails fromMap(map) {
    return CollectionDetails(
        name: map['name'],
        type: CollectionType.values[map['typeIndex']],
        fromLanguage: LanguageName.values[map['fromLanguageIndex']],
        toLanguage: map['toLanguageIndex'] != null
            ? LanguageName.values[map['toLanguageIndex']]
            : null);
  }

  String getStringId() =>
      "${name}_${type.index}_${fromLanguage.index}" +
      ((toLanguage != null) ? "_${toLanguage!.index}" : "");

  Map<String, dynamic> toMap() {
    var out = {
      'name': name,
      'typeIndex': type.index,
      'fromLanguageIndex': fromLanguage.index
    };

    if (toLanguage != null) {
      out['toLanguageIndex'] = toLanguage!.index;
    }

    return out;
  }

  @override
  bool operator ==(Object other) =>
      other is CollectionDetails &&
      other.runtimeType == runtimeType &&
      other.getStringId() == getStringId();

  @override
  int get hashCode => getStringId().hashCode;
}
