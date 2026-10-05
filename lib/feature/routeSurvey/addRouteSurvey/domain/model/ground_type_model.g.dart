// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ground_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroundTypeModelAdapter extends TypeAdapter<GroundTypeModel> {
  @override
  final int typeId = 3;

  @override
  GroundTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroundTypeModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GroundTypeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroundTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
