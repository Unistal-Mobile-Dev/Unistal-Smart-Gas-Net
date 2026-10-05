// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terrain_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TerrainTypeModelAdapter extends TypeAdapter<TerrainTypeModel> {
  @override
  final int typeId = 4;

  @override
  TerrainTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TerrainTypeModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TerrainTypeModel obj) {
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
      other is TerrainTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
