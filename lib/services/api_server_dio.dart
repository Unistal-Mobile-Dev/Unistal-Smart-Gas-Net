import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/connectivity_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/singleton.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_error_widget.dart';
import 'package:mime/mime.dart';

import 'apis.dart';

class ApiDioHelper {

  static BuildContext? context = Singleton.instanceInit()?.context;
  static var header = {"Content-Type": "application/x-www-form-urlencoded"};

  static addToken() {
    String token = UserInfo.instanceInit()!.userData != null
        ? UserInfo.instanceInit()!.userData!.token.toString()
        : "";
    header["Authorization"] = token;
  }

  static Future<dynamic> getData({
    required String urlEndPoint,
  }) async {
    try {
      if (!await ConnectivityHelper.allConnectivityCheck(context: context!)) {
        return null;
      }
      addToken();
      String url = APIs.baseUrl + urlEndPoint;
      log(Uri.parse(url.toString()).toString());
      final response = await Dio().get(Uri.parse(url).toString());
      log("URL --> $url");
      log("Response Data --> ${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data;
      }
    } on DioException catch (error) {
      debugPrint("Dio Error --> ${error.message}");
      final statusCode = error.response?.statusCode;
      Response? errorMessage = error.response;
      return await _handleError(statusCode :statusCode, errorMessage: errorMessage,context: context!);
    } catch (e) {
      log("Catch Error --> $e");
      if (context != null) {
        SnackBarErrorWidget(context!).show(message: "Something Went Wrong");
      }
      throw 'Something Went Wrong';
    }
  }

  static Future<dynamic> postData({
    required String urlEndPoint,
    Map<String, dynamic>? param,
    Map<String, String>? headers,
    String? contentType,
    formData,
  }) async {
    try {
      if (!await ConnectivityHelper.allConnectivityCheck(context: context!)) {
        return null;
      }
      String url = APIs.baseUrl + urlEndPoint;
      log(url);
      addToken();
      log(header.toString());
      var options = Options(
        headers: headers ?? {},
        contentType:
        contentType ?? (formData != null ? "multipart/form-data" : null),
      );
      var response = await Dio().post(Uri.parse(url).toString(),
          options: options, data: param ?? FormData.fromMap(formData));
      log("URL --> $url");
      log("Response Data --> ${response.data}");
      log("param --> ${param}");
      log("formData --> ${formData}");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data;
      }
    } on DioException catch (error) {
      debugPrint("Dio Error --> ${error.message}");
      final statusCode = error.response?.statusCode;
      Response? errorMessage = error.response;
      return await _handleError(statusCode :statusCode, errorMessage: errorMessage,context: context!);
    } catch (e) {
      log("Multipart Error --> $e");
      if (context != null) {
        SnackBarErrorWidget(context!).show(message: "Something Went Wrong");
      }
      throw 'Something Went Wrong';
    }
  }

  static Future<dynamic> postDataWithFile({
    required String urlEndPoint,
    required Map<String, dynamic> body,
    required List<ImageRequestObject> imageRequestObject,
    required BuildContext context,
  }) async {
    try {
      addToken();
      String url = APIs.baseUrl + urlEndPoint;
      log(url);
      log(body.toString());
      log(header.toString());
      if (!await ConnectivityHelper.allConnectivityCheck(context: context)) {
        return null;
      }
      final formData = FormData.fromMap(body);
      for (var element in imageRequestObject) {
        if (element.path!.isNotEmpty && !element.path!.startsWith("http")) {
          final mimeTypeData =
          lookupMimeType(element.path!, headerBytes: [0xFF, 0xD8])
              ?.split('/');
          if (mimeTypeData != null && mimeTypeData.length == 2) {
            formData.files.add(
              MapEntry(
                element.key!,
                await MultipartFile.fromFile(
                  element.path!,
                  contentType: DioMediaType(mimeTypeData[0], mimeTypeData[1]),
                ),
              ),
            );
          }
        } else {
          body[element.key!] = element.path;
        }
      }


      final response = await Dio().post(Uri.parse(url).toString(), data: formData);

      debugPrint("URL --> $url");
      debugPrint("Response Data --> ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data;
      }
    } on DioException catch (error) {
      debugPrint("Dio Error --> ${error.message}");
      final statusCode = error.response?.statusCode;
      Response? errorMessage = error.response;
      return await _handleError(statusCode :statusCode, errorMessage: errorMessage,context: context);
    } catch (e) {
      debugPrint("Multipart Error --> $e");
      SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: "Something Went Wrong");
      throw 'Something Went Wrong';
    }
  }

  static Future<void> _handleError(
      {int? statusCode, Response? errorMessage, required BuildContext context}) async {
    if(statusCode == 400){
      return errorMessage!.data;
    }else if(statusCode == 401){
      log("errorStatus(401)-->${errorMessage.toString()}");
      SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: errorMessage!.data.toString());
    }else if(statusCode == 404){
      log("errorStatus(404)-->${errorMessage.toString()}");
    return  SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: errorMessage!.data.toString());
    }else if(statusCode == 415){
      return await SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: errorMessage!.data.toString());
    } else if(statusCode == 500){
      return await SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: errorMessage!.data.toString());
    } else{
      return await SnackBarErrorWidget(!context.mounted ? context : context)
          .show(message: errorMessage!.data.toString());
    }
  }
}

class ImageRequestObject {
  String? key;
  String? path;

  ImageRequestObject(this.key, this.path);
}