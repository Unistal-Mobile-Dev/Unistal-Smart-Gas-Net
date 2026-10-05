// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alignment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlignmentModelAdapter extends TypeAdapter<AlignmentModel> {
  @override
  final int typeId = 2;

  @override
  AlignmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlignmentModel(
      id: fields[0] as String?,
      alignmentName: fields[1] as String?,
      chainageFrom: fields[2] as String?,
      chainageTo: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AlignmentModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.alignmentName)
      ..writeByte(2)
      ..write(obj.chainageFrom)
      ..writeByte(3)
      ..write(obj.chainageTo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlignmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
