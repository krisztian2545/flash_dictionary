class CardValues {
  const CardValues(this.confidenceValue, [this.lastGameValue = 0]);

  static const CardValues zero = CardValues(0);

  final int confidenceValue;
  final int lastGameValue;

  Map<String, dynamic> toMap(String front) => {
        'front': front,
        'confidenceValue': confidenceValue,
        'lastGameValue': lastGameValue,
      };

  static CardValues fromMap(Map map) =>
      CardValues(map['confidenceValue'], map['lastGameValue']);
}
