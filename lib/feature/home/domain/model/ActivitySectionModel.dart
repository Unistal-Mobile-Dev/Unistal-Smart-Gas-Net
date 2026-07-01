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

class ActivitySectionData {
  String? activityType;
  String? sortOrder;
  String? weightage;
  String? formateNo;
  String? id;
  String? createdAt;
  String? status;
  String? spreadId;
  String? activityName;
  String? activityCode;
  String? spreadName;
  String? sectionName;
  String? sectionId;
  String? activityId;
  String? modelName;
  String? updatedAt;
  String? scope;
  String? startDate;
  String? endDate;
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
