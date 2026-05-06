List<HindranceListData> hindranceListData(var json) {
  return List<HindranceListData>.from(json.map((x) => HindranceListData.fromJson(x)));
}

class HindranceListModel {
  int? success;
  bool? error;
  int? total;
  List<HindranceListData>? data;

  HindranceListModel({this.success, this.error, this.total, this.data});

  HindranceListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    total = json['total'];
    if (json['data'] != null) {
      data = <HindranceListData>[];
      json['data'].forEach((v) {
        data!.add( HindranceListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HindranceListData {
  String? id;
  String? spreadId;
  String? sectionId;
  String? activityId;
  String? reportNo;
  String? reportDate;
  String? chainageFrom;
  String? chainageTo;
  String? areaHold;
  String? fromDate;
  String? toDate;
  dynamic dateDifference;
  dynamic remarks;
  dynamic responsibility;
  String? status;
  String? reason;
  String? createdBy;
  dynamic updatedBy;
  dynamic openBy;
  dynamic openDate;
  dynamic openSign;
  dynamic closeBy;
  dynamic closeDate;
  dynamic closeSign;
  String? createdAt;
  String? updatedAt;
  String? source;
  dynamic weatherId;
  dynamic attachFile;
  String? hindranceCategory;
  String? hindranceType;
  String? activityAffected;
  String? responsibleBy;
  String? location;
  String? latitude;
  String? longitude;
  String? spreadName;
  String? sectionName;
  dynamic activityName;
  String? createdUser;
  dynamic openByUser;
  dynamic closeByUser;
  String? hindranceCategoryName;
  String? hindranceTypeName;
  int? sno;
  String? activity;
  String? editRemarks;

  HindranceListData(
      {this.id,
        this.spreadId,
        this.sectionId,
        this.activityId,
        this.reportNo,
        this.reportDate,
        this.chainageFrom,
        this.chainageTo,
        this.areaHold,
        this.fromDate,
        this.toDate,
        this.dateDifference,
        this.remarks,
        this.responsibility,
        this.status,
        this.reason,
        this.createdBy,
        this.updatedBy,
        this.openBy,
        this.openDate,
        this.openSign,
        this.closeBy,
        this.closeDate,
        this.closeSign,
        this.createdAt,
        this.updatedAt,
        this.source,
        this.weatherId,
        this.attachFile,
        this.hindranceCategory,
        this.hindranceType,
        this.activityAffected,
        this.responsibleBy,
        this.location,
        this.latitude,
        this.longitude,
        this.spreadName,
        this.sectionName,
        this.activityName,
        this.createdUser,
        this.openByUser,
        this.closeByUser,
        this.hindranceCategoryName,
        this.hindranceTypeName,
        this.sno,
        this.activity,
        this.editRemarks,
       });

  HindranceListData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    spreadId = json['spread_id'] ?? "";
    sectionId = json['section_id'] ?? "";
    activityId = json['activity_id'] ?? "";
    reportNo = json['report_no'] ?? "";
    reportDate = json['report_date'] ?? "";
    chainageFrom = json['chainage_from'] ?? "";
    chainageTo = json['chainage_to'] ?? "";
    areaHold = json['area_hold'] ?? "";
    fromDate = json['from_date'] ?? "";
    toDate = json['to_date'] ?? "";
    dateDifference = json['date_difference'] ?? "";
    remarks = json['remarks'] ?? "";
    responsibility = json['responsibility'] ?? "";
    status = json['status'] ?? "";
    reason = json['reason'] ?? "";
    createdBy = json['created_by'] ?? "";
    updatedBy = json['updated_by'] ?? "";
    openBy = json['open_by'] ?? "";
    openDate = json['open_date'] ?? "";
    openSign = json['open_sign'] ?? "";
    closeBy = json['close_by'] ?? "";
    closeDate = json['close_date'] ?? "";
    closeSign = json['close_sign'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    source = json['source'] ?? "";
    weatherId = json['weather_id'] ?? "";
    attachFile = json['attach_file'] ?? "";
    hindranceCategory = json['hindrance_category'] ?? "";
    hindranceType = json['hindrance_type'] ?? "";
    activityAffected = json['activity_affected'] ?? "";
    responsibleBy = json['responsible_by'] ?? "";
    location = json['location'] ?? "";
    latitude = json['latitude'] ?? "";
    longitude = json['longitude'] ?? "";
    spreadName = json['spread_name'] ?? "";
    sectionName = json['section_name'] ?? "";
    activityName = json['activity_name'] ?? "";
    createdUser = json['created_user'] ?? "";
    openByUser = json['open_by_user'] ?? "";
    closeByUser = json['close_by_user'] ?? "";
    hindranceCategoryName = json['hindrance_category_name'] ?? "";
    hindranceTypeName = json['hindrance_type_name'] ?? "";
    sno = json['sno'] ?? "";
    activity = json['activity'] ?? "";
    editRemarks = json['edit_remarks'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['spread_id'] = spreadId;
    data['section_id'] = sectionId;
    data['activity_id'] = activityId;
    data['report_no'] = reportNo;
    data['report_date'] = reportDate;
    data['chainage_from'] = chainageFrom;
    data['chainage_to'] = chainageTo;
    data['area_hold'] = areaHold;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['date_difference'] = dateDifference;
    data['remarks'] = remarks;
    data['responsibility'] = responsibility;
    data['status'] = status;
    data['reason'] = reason;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['open_by'] = openBy;
    data['open_date'] = openDate;
    data['open_sign'] = openSign;
    data['close_by'] = closeBy;
    data['close_date'] = closeDate;
    data['close_sign'] = closeSign;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['source'] = source;
    data['weather_id'] = weatherId;
    data['attach_file'] = attachFile;
    data['hindrance_category'] = hindranceCategory;
    data['hindrance_type'] = hindranceType;
    data['activity_affected'] = activityAffected;
    data['responsible_by'] = responsibleBy;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['spread_name'] = spreadName;
    data['section_name'] = sectionName;
    data['activity_name'] = activityName;
    data['created_user'] = createdUser;
    data['open_by_user'] = openByUser;
    data['close_by_user'] = closeByUser;
    data['hindrance_category_name'] = hindranceCategoryName;
    data['hindrance_type_name'] = hindranceTypeName;
    data['sno'] = sno;
    data['activity'] = activity;
    data['edit_remarks'] = editRemarks;
    return data;
  }
}
