import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileModel {
  List<int>? fileByte;
  String? fileName;

  FileModel({
    this.fileName,
    this.fileByte,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attached_file'] = writeToFile(data: fileByte!, fileName: fileName.toString());
    return data;
  }

  static Future<File> writeToFile({required List<int>  data, required String fileName}) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/$fileName';
    return File(filePath).writeAsBytes(data);
  }

  static Future<dynamic> deleteFileInMemory({required File file}) async {
    try {
      if (await file.exists()) {
        await file.delete();
        return  true;
      } else{
        if(kDebugMode){
          print("File not found - :");
        }
        return  false;
      }
    } catch (e) {
      if(kDebugMode){
        print("Delete file error - :  ${e.toString()}");
      }
      return  false;
    }
  }
}