// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_names.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageNameAdapter extends TypeAdapter<LanguageName> {
  @override
  final int typeId = 2;

  @override
  LanguageName read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LanguageName.eng;
      case 1:
        return LanguageName.hun;
      case 2:
        return LanguageName.por;
      case 3:
        return LanguageName.deu;
      case 4:
        return LanguageName.rus;
      case 5:
        return LanguageName.chi;
      case 6:
        return LanguageName.spa;
      case 7:
        return LanguageName.ita;
      case 8:
        return LanguageName.nld;
      case 9:
        return LanguageName.pol;
      case 10:
        return LanguageName.ces;
      case 11:
        return LanguageName.jpn;
      case 12:
        return LanguageName.swe;
      case 13:
        return LanguageName.fin;
      case 14:
        return LanguageName.arb;
      case 15:
        return LanguageName.tur;
      case 16:
        return LanguageName.ben;
      case 17:
        return LanguageName.hin;
      case 18:
        return LanguageName.kor;
      case 19:
        return LanguageName.tha;
      case 20:
        return LanguageName.fra;
      default:
        return LanguageName.eng;
    }
  }

  @override
  void write(BinaryWriter writer, LanguageName obj) {
    switch (obj) {
      case LanguageName.eng:
        writer.writeByte(0);
        break;
      case LanguageName.hun:
        writer.writeByte(1);
        break;
      case LanguageName.por:
        writer.writeByte(2);
        break;
      case LanguageName.deu:
        writer.writeByte(3);
        break;
      case LanguageName.rus:
        writer.writeByte(4);
        break;
      case LanguageName.chi:
        writer.writeByte(5);
        break;
      case LanguageName.spa:
        writer.writeByte(6);
        break;
      case LanguageName.ita:
        writer.writeByte(7);
        break;
      case LanguageName.nld:
        writer.writeByte(8);
        break;
      case LanguageName.pol:
        writer.writeByte(9);
        break;
      case LanguageName.ces:
        writer.writeByte(10);
        break;
      case LanguageName.jpn:
        writer.writeByte(11);
        break;
      case LanguageName.swe:
        writer.writeByte(12);
        break;
      case LanguageName.fin:
        writer.writeByte(13);
        break;
      case LanguageName.arb:
        writer.writeByte(14);
        break;
      case LanguageName.tur:
        writer.writeByte(15);
        break;
      case LanguageName.ben:
        writer.writeByte(16);
        break;
      case LanguageName.hin:
        writer.writeByte(17);
        break;
      case LanguageName.kor:
        writer.writeByte(18);
        break;
      case LanguageName.tha:
        writer.writeByte(19);
        break;
      case LanguageName.fra:
        writer.writeByte(20);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
