// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlashCardAdapter extends TypeAdapter<FlashCard> {
  @override
  final int typeId = 2;

  @override
  FlashCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlashCard(
      id: fields[0] as String,
      question: fields[1] as String,
      rightResponse: fields[2] as String,
      wrongResponses: (fields[3] as List).cast<String>(),
      subSubjectId: fields[4] as String,
      lastPlayedDate: fields[5] as DateTime?,
      lastPlayedStatus: fields[6] as String?,
      currentPlayingRank: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FlashCard obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.rightResponse)
      ..writeByte(3)
      ..write(obj.wrongResponses)
      ..writeByte(4)
      ..write(obj.subSubjectId)
      ..writeByte(5)
      ..write(obj.lastPlayedDate)
      ..writeByte(6)
      ..write(obj.lastPlayedStatus)
      ..writeByte(7)
      ..write(obj.currentPlayingRank);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
