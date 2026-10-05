import 'package:flutter_unistal_smart_gas_net/utils/HiveDatabase/hive_box_name.dart';
import 'package:hive/hive.dart';
part 'activity_section_model.g.dart';

List<ActivitySectionData> activitySectionListResponse(var json) {
  return List<ActivitySectionData>.from(
      json.map((x) => ActivitySectionData.fromJson(x)));
}

class ActivitySectionModel {
  int? success;
  bool? error;
  List<ActivitySectionData>? data;

  ActivitySectionModel({this.success, this.error, this.data});

  ActivitySectionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? "";
    error = json['error'] ?? "";
    if (json['data'] != null) {
      data = <ActivitySectionData>[];
      json['data'].forEach((v) {
        data!.add(new ActivitySectionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: HiveTypeId.activitySectionId)
class ActivitySectionData extends HiveObject {
  @HiveField(0)
  String? activityType;

  @HiveField(1)
  String? sortOrder;

  @HiveField(2)
  String? weightage;

  @HiveField(3)
  String? formateNo;

  @HiveField(4)
  String? id;

  @HiveField(5)
  String? createdAt;

  @HiveField(6)
  String? status;

  @HiveField(7)
  String? spreadId;

  @HiveField(8)
  String? activityName;

  @HiveField(9)
  String? activityCode;

  @HiveField(10)
  String? spreadName;

  @HiveField(11)
  String? sectionName;

  @HiveField(12)
  String? sectionId;

  @HiveField(13)
  String? activityId;

  @HiveField(14)
  String? modelName;

  @HiveField(15)
  String? updatedAt;

  @HiveField(16)
  String? scope;

  @HiveField(17)
  String? startDate;

  @HiveField(18)
  String? endDate;

  @HiveField(19)
  String? appJoint;

  ActivitySectionData(
      {
        this.activityType,
        this.sortOrder,
        this.weightage,
        this.formateNo,
        this.id,
        this.createdAt,
        this.status,
        this.spreadId,
        this.activityName,
        this.activityCode,
        this.spreadName,
        this.sectionName,
        this.sectionId,
        this.activityId,
        this.modelName,
        this.updatedAt,
        this.scope,
        this.startDate,
        this.endDate,
        this.appJoint,
      });

  ActivitySectionData.fromJson(Map<String, dynamic> json) {
    activityType = json['activity_type'] ?? "";
    sortOrder = json['sort_order'] ?? "";
    weightage = json['weightage'] ?? "";
    formateNo = json['formate_no'] ?? "";
    id = json['id'] ?? "";
    createdAt = json['created_at'] ?? "";
    status = json['status'] ?? "";
    spreadId = json['spread_id'] ?? "";
    activityName = json['activity_name'] ?? "";
    activityCode = json['activity_code'] ?? "";
    spreadName = json['spread_name'] ?? "";
    sectionName = json['section_name'] ?? "";
    sectionId = json['section_id'] ?? "";
    activityId = json['activity_id'] ?? "";
    modelName = json['modelName'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    scope = json['scope'] ?? "";
    startDate = json['start_date'] ?? "";
    endDate = json['end_date'] ?? "";
    appJoint = json['app_joint'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_type'] = activityType;
    data['sort_order'] = sortOrder;
    data['weightage'] = weightage;
    data['formate_no'] = formateNo;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['status'] = status;
    data['spread_id'] = spreadId;
    data['activity_name'] = activityName;
    data['activity_code'] = activityCode;
    data['spread_name'] = spreadName;
    data['section_name'] = sectionName;
    data['section_id'] = sectionId;
    data['activity_id'] = activityId;
    data['modelName'] = modelName;
    data['updated_at'] = updatedAt;
    data['scope'] = scope;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['app_joint'] = appJoint;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return activityName.toString();
  }
}
