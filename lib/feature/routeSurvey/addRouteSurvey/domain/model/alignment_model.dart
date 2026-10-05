import 'package:flutter_unistal_smart_gas_net/utils/HiveDatabase/hive_box_name.dart';
import 'package:hive/hive.dart';
part 'alignment_model.g.dart';

List<AlignmentModel> alignmentResponseList(var json) {
  return List<AlignmentModel>.from(json.map((x) => AlignmentModel.fromJson(x)));
}

@HiveType(typeId: HiveTypeId.alignmentId)
class AlignmentModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? alignmentName;
  @HiveField(2)
  String? chainageFrom;
  @HiveField(3)
  String? chainageTo;

  AlignmentModel(
      {this.id, this.alignmentName, this.chainageFrom, this.chainageTo});

  AlignmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alignmentName = json['alignment_name'];
    chainageFrom = json['chainage_from'];
    chainageTo = json['chainage_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = alignmentName;
    data['value'] = "";
    return data;
  }
}
