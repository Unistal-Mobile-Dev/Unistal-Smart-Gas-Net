import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

List<LoginDataModel> loginScreenResponseData(var json) {
  return List<LoginDataModel>.from(json.map((x) => LoginDataModel.fromJson(x)));
}

LoginDataModel loginResponse(var json) {
  return LoginDataModel.fromJson(json);
}

class LoginDataModel {
  String? userId;
  String? email;
  String? moduleId;
  String? name;
  String? userStatus;
  String? pwdChanged;
  dynamic modules;
  String? schema;
  String? spreadId;
  String? sectionId;
  String? token;
  RoleType? roleType;

  LoginDataModel({
    this.userId,
    this.email,
    this.moduleId,
    this.name,
    this.userStatus,
    this.pwdChanged,
    this.modules,
    this.schema,
    this.spreadId,
    this.sectionId,
    this.token,
    this.roleType,
  });

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    email = json['email'];
    moduleId = json['module_id'];
    name = json['name'];
    userStatus = json['user_status'];
    pwdChanged = json['pwd_changed'];
    modules = json['modules'];
    schema = json['schema'];
    spreadId = json['spread_id'];
    sectionId = json['section_id'];
    roleType =
        json['role'] != null ? getRole(role: json['role']) : RoleType.engineer;
  }

  getRole({required String role}) {
    switch (role) {
      case "engineer":
        return RoleType.engineer;
    }
  }
}

class LoginScreenRequestModel {
  final String userEmailId;
  final String password;
  final String firebaseId;
  final String deviceId;

  LoginScreenRequestModel(
      {required this.userEmailId,
      required this.password,
      required this.firebaseId,
      required this.deviceId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": userEmailId,
      "password": password,
      "firebase_id": firebaseId,
      "device_id": deviceId,
    };
    return map;
  }
}
