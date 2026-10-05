import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

class HiveDataBase {
  static Box<ActivitySectionData>? activitySectionBox;
  static Box<WeatherModel>? weatherBox;
  static Box<AlignmentModel>? alignmentBox;
  static Box<GroundTypeModel>? groundTypeBox;
  static Box<TerrainTypeModel>? terrainTypeBox;
  static Box<OfflineRecordModel>? offlineRecordBox;



  Future<void> init() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    Directory filesDir = Directory(tempDir.path)..createSync(recursive: true);
    await Hive.initFlutter(filesDir.path);

    Hive.registerAdapter(ActivitySectionDataAdapter());
    Hive.registerAdapter(WeatherModelAdapter());
    Hive.registerAdapter(AlignmentModelAdapter());
    Hive.registerAdapter(GroundTypeModelAdapter());
    Hive.registerAdapter(TerrainTypeModelAdapter());
    Hive.registerAdapter(OfflineRecordModelAdapter());

    activitySectionBox = await Hive.openBox<ActivitySectionData>(HiveBoxName.activitySectionBox);
    weatherBox = await Hive.openBox<WeatherModel>(HiveBoxName.weatherBox);
    alignmentBox = await Hive.openBox<AlignmentModel>(HiveBoxName.alignmentBox);
    groundTypeBox = await Hive.openBox<GroundTypeModel>(HiveBoxName.groundTypeBox);
    terrainTypeBox = await Hive.openBox<TerrainTypeModel>(HiveBoxName.terrainTypeBox);
    offlineRecordBox = await Hive.openBox<OfflineRecordModel>(HiveBoxName.offlineRecordBox);


  }
}