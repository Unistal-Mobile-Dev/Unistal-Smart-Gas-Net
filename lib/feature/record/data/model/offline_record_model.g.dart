// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_record_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineRecordModelAdapter extends TypeAdapter<OfflineRecordModel> {
  @override
  final int typeId = 5;

  @override
  OfflineRecordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineRecordModel(
      activityName: fields[0] as String?,
      url: fields[1] as String?,
      body: (fields[2] as Map?)?.cast<String, String>(),
      filePath: fields[3] as String?,
      reportNo: fields[4] as String?,
      activityDate: fields[5] as String?,
      createdAt: fields[6] as int?,
      lastError: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineRecordModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.activityName)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.filePath)
      ..writeByte(4)
      ..write(obj.reportNo)
      ..writeByte(5)
      ..write(obj.activityDate)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.lastError);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineRecordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
