// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_section_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivitySectionDataAdapter extends TypeAdapter<ActivitySectionData> {
  @override
  final int typeId = 0;

  @override
  ActivitySectionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivitySectionData(
      activityType: fields[0] as String?,
      sortOrder: fields[1] as String?,
      weightage: fields[2] as String?,
      formateNo: fields[3] as String?,
      id: fields[4] as String?,
      createdAt: fields[5] as String?,
      status: fields[6] as String?,
      spreadId: fields[7] as String?,
      activityName: fields[8] as String?,
      activityCode: fields[9] as String?,
      spreadName: fields[10] as String?,
      sectionName: fields[11] as String?,
      sectionId: fields[12] as String?,
      activityId: fields[13] as String?,
      modelName: fields[14] as String?,
      updatedAt: fields[15] as String?,
      scope: fields[16] as String?,
      startDate: fields[17] as String?,
      endDate: fields[18] as String?,
      appJoint: fields[19] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ActivitySectionData obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.activityType)
      ..writeByte(1)
      ..write(obj.sortOrder)
      ..writeByte(2)
      ..write(obj.weightage)
      ..writeByte(3)
      ..write(obj.formateNo)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.spreadId)
      ..writeByte(8)
      ..write(obj.activityName)
      ..writeByte(9)
      ..write(obj.activityCode)
      ..writeByte(10)
      ..write(obj.spreadName)
      ..writeByte(11)
      ..write(obj.sectionName)
      ..writeByte(12)
      ..write(obj.sectionId)
      ..writeByte(13)
      ..write(obj.activityId)
      ..writeByte(14)
      ..write(obj.modelName)
      ..writeByte(15)
      ..write(obj.updatedAt)
      ..writeByte(16)
      ..write(obj.scope)
      ..writeByte(17)
      ..write(obj.startDate)
      ..writeByte(18)
      ..write(obj.endDate)
      ..writeByte(19)
      ..write(obj.appJoint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivitySectionDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
