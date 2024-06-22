// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subsubject.dart';

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
      uname: fields[0] as String,
      title: fields[1] as String,
      subject: fields[2] as Subject,
    );
  }

  @override
  void write(BinaryWriter writer, SubSubject obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uname)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subject);
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
