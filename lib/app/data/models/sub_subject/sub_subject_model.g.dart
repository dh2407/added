// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_subject_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubSubjectAdapter extends TypeAdapter<SubSubject> {
  @override
  final int typeId = 1;

  @override
  SubSubject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubSubject(
      id: fields[0] as String,
      title: fields[1] as String,
      subjectId: fields[2] as String,
      flashCards: (fields[3] as List).cast<FlashCard>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubSubject obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subjectId)
      ..writeByte(3)
      ..write(obj.flashCards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubSubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
