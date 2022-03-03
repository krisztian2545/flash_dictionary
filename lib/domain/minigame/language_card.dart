class LanguageCard {
  LanguageCard(
      {required this.front,
      required this.back}); // TODO move contructors to the top

  final String front;
  final String back;

  Map<String, dynamic> toMap() {
    return {
      'front': front,
      'back': back,
    };
  }

  static LanguageCard fromMap(Map map) =>
      LanguageCard(front: map['front'] ?? "", back: map['back'] ?? "");

  @override
  bool operator ==(Object other) =>
      other is LanguageCard &&
      other.runtimeType == runtimeType &&
      other.front == front;

  @override
  int get hashCode => toMap().hashCode;

}
