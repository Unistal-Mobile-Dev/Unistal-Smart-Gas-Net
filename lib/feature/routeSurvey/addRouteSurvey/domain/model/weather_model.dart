import 'package:flutter_unistal_smart_gas_net/utils/HiveDatabase/hive_box_name.dart';
import 'package:hive/hive.dart';
part 'weather_model.g.dart';

List<WeatherModel> weatherListResponse(var json) {
  return List<WeatherModel>.from(json.map((x) => WeatherModel.fromJson(x)));
}

@HiveType(typeId: HiveTypeId.weatherId)
class WeatherModel {
  @HiveField(0)
  dynamic id;
  @HiveField(1)
  String? name;

  WeatherModel({this.name, this.id});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(id: json['id'] ?? "", name: json['name'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = "";
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return name.toString();
  }
}
