// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_with_params.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordWithParamsAdapter extends TypeAdapter<WordWithParams> {
  @override
  final int typeId = 1;

  @override
  WordWithParams read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordWithParams(
      fields[0] as String,
      fields[1] as LanguageName,
      fields[2] as LanguageName,
    );
  }

  @override
  void write(BinaryWriter writer, WordWithParams obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.fromLanguage)
      ..writeByte(2)
      ..write(obj.toLanguage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordWithParamsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
