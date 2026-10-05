import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
part 'terrain_type_model.g.dart';


List<TerrainTypeModel> terrainListResponse(var json) {
  return List<TerrainTypeModel>.from(
      json.map((x) => TerrainTypeModel.fromJson(x)));
}

@HiveType(typeId: HiveTypeId.terrainTypeId)
class TerrainTypeModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;

  TerrainTypeModel({this.id, this.name});

  TerrainTypeModel.fromJson(Map<String, dynamic> json) {
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
