import 'package:flutter_unistal_smart_gas_net/utils/HiveDatabase/hive_box_name.dart';
import 'package:hive/hive.dart';
part 'ground_type_model.g.dart';


List<GroundTypeModel> groundTypeListResponse(var json) {
  return List<GroundTypeModel>.from(
      json.map((x) => GroundTypeModel.fromJson(x)));
}

@HiveType(typeId: HiveTypeId.groundTypeId)
class GroundTypeModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;

  GroundTypeModel({this.id, this.name});

  GroundTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return name.toString();
  }
}
