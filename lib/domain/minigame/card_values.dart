class CardValues {
  CardValues(this.confidenceValue, [this.lastGameValue = 0]);

  static CardValues get zero => CardValues(0);

  int confidenceValue;
  int lastGameValue;

  Map<String, dynamic> toMap(String front) =>
      {
        'front': front,
        'confidenceValue': confidenceValue,
        'lastGameValue': lastGameValue,
      };

  static CardValues? fromMap(Map? map) {
    if (map == null) {
      return null;
    }
    CardValues(map['confidenceValue'], map['lastGameValue']);
  }

}
