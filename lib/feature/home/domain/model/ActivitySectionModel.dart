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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivitySectionData {
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

  ActivitySectionData(
      {this.sortOrder,
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
        this.endDate});

  ActivitySectionData.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sort_order'] = this.sortOrder;
    data['weightage'] = this.weightage;
    data['formate_no'] = this.formateNo;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['spread_id'] = this.spreadId;
    data['activity_name'] = this.activityName;
    data['activity_code'] = this.activityCode;
    data['spread_name'] = this.spreadName;
    data['section_name'] = this.sectionName;
    data['section_id'] = this.sectionId;
    data['activity_id'] = this.activityId;
    data['modelName'] = this.modelName;
    data['updated_at'] = this.updatedAt;
    data['scope'] = this.scope;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
