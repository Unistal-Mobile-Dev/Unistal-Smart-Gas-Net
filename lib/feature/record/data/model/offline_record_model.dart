import 'package:flutter_unistal_smart_gas_net/utils/HiveDatabase/hive_box_name.dart';
import 'package:hive/hive.dart';

part 'offline_record_model.g.dart';

// =============================================================================
// OFFLINE RECORD MODEL
// Saari activities (Route Survey, ROU Handover, Clear & Grade, Trenching,
// Back Filling ...) ka offline data isi EK model me save hota hai.
//
// Har activity aakhir me server ko yahi bhejti hai:
//   url  + body (Map) + file
// Isliye har activity ke liye alag model banane ki zaroorat nahi.
// =============================================================================

@HiveType(typeId: HiveTypeId.offlineRecordId)
class OfflineRecordModel extends HiveObject {
  /// Activity ka naam: "Trenching", "Back Filling" ... (list me dikhane ke liye)
  @HiveField(0)
  String? activityName;

  /// Kis API par bhejna hai
  @HiveField(1)
  String? url;

  /// Server ko jaane wala poora data (schema, user_id, chainage ...)
  @HiveField(2)
  Map<String, String>? body;

  /// Attach file ka path (app ke permanent folder me copy kiya hua)
  @HiveField(3)
  String? filePath;

  /// Record screen ki list me dikhane ke liye
  @HiveField(4)
  String? reportNo;

  @HiveField(5)
  String? activityDate;

  /// Kab save hua (milliseconds)
  @HiveField(6)
  int? createdAt;

  /// Server ne mana kiya to error yahan save hoga (list me dikha sakte ho)
  @HiveField(7)
  String? lastError;

  OfflineRecordModel({
    this.activityName,
    this.url,
    this.body,
    this.filePath,
    this.reportNo,
    this.activityDate,
    this.createdAt,
    this.lastError,
  });
}