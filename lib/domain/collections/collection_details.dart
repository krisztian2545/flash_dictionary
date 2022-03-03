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

  static CollectionDetails fromMap(Map map) {
    return CollectionDetails(
        name: map['name'],
        type: CollectionType.values[map['typeIndex']],
        fromLanguage: LanguageName.values[map['fromLanguageIndex']],
        toLanguage: map['toLanguageIndex'] != null
            ? LanguageName.values[map['toLanguageIndex']]
            : null);
  }

  String getStringId() =>
      "${name.hashCode}_${type.index}_${fromLanguage.index}" + // TODO collection name must be ascii ...
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
