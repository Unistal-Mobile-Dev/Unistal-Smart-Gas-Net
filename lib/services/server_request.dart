import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_unistal_smart_gas_net/localDataBase/preferences_name.dart';
import 'package:flutter_unistal_smart_gas_net/localDataBase/shared_preferences_utils.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/connectivity_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_navigator.dart';
import 'package:mime/mime.dart';

class ServerRequest {
  static final Dio _dio = Dio();

  static final Map<String, dynamic> header = {
    "Content-Type": "application/x-www-form-urlencoded",
  };

  // ================= INIT — call once at app start =================
  static void init() {
    _dio.options = BaseOptions(
      baseUrl: AppConfig.baseUrl ?? "",
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      headers: header,
    );
    // Prevent duplicate interceptors
    _dio.interceptors.clear();
    // Interceptor — token + static header auto add on every request
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = UserInfo.instanceInit()?.userData?.token ?? "";
          if (token.isNotEmpty) {
            options.headers["Authorization"] = token;
          }

          log("══════════════════════════════════════════════");
          log("REQUEST");
          log("METHOD : ${options.method}");
          log("URL    : ${options.uri}");

          if (options.queryParameters.isNotEmpty) {
            log("QUERY  : ${options.queryParameters}");
          }

          log("HEADERS:\n${options.headers}");

          if (options.method != "GET") {
            log("BODY TYPE : ${options.data.runtimeType}");
            log("BODY :\n${_formatBody(options.data)}");
          }

          log("══════════════════════════════════════════════");

          return handler.next(options);
        },
        onResponse: (response, handler) {
          updateCookie(response);
          log("══════════════════════════════════════════════");
          log("RESPONSE");
          log("STATUS : ${response.statusCode}");
          log("URL    : ${response.requestOptions.uri}");
          log("BODY :");
          log(response.data.toString());
          log("══════════════════════════════════════════════");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log("══════════════════════════════════════════════");
          log("ERROR");

          log("URL : ${e.requestOptions.uri}");

          if (e.response != null) {
            log("STATUS : ${e.response?.statusCode}");
            log("BODY : ${e.response?.data}");
          } else {
            log("MESSAGE : ${e.message}");
          }

          log("══════════════════════════════════════════════");
          return handler.next(e);
        },
      ),
    );
  }

  // ================= BODY LOG FORMATTER =================
  static String _formatBody(dynamic data) {
    if (data == null) {
      return "<EMPTY>";
    }

    if (data is FormData) {
      final buffer = StringBuffer();

      if (data.fields.isNotEmpty) {
        buffer.writeln("Fields:");
        for (final field in data.fields) {
          buffer.writeln("${field.key}: ${field.value}");
        }
      }

      if (data.files.isNotEmpty) {
        buffer.writeln();
        buffer.writeln("Files:");

        for (final file in data.files) {
          buffer.writeln(
            "${file.key}: ${file.value.filename} (${file.value.length} bytes)",
          );
        }
      }

      return buffer.toString();
    }

    if (data is Map) {
      final buffer = StringBuffer();

      data.forEach((key, value) {
        buffer.writeln("$key : $value");
      });

      return buffer.toString();
    }

    if (data is List) {
      return data.toString();
    }

    if (data is String) {
      return data;
    }

    return data.toString();
  }

  static Options _buildOptions(Map<String, dynamic>? headers) {
    final merged = <String, dynamic>{...header};
    if (headers != null) merged.addAll(headers);
    return Options(headers: merged);
  }

  // ================= GET =================
  static Future<dynamic> getData({
    required String urlEndPoint,
    Map<String, dynamic>? headers,
    bool showNoInternetPopup = true,
  }) async {
    try {
      if (showNoInternetPopup) {
        final context = AppNavigator.navigatorKey.currentContext;
        if (context != null &&
            await ConnectivityHelper.allConnectivityCheck(context: context) ==
                false) {
          return null;
        }
      } else {
        // Silent check, koi popup nahi
        if (!await ConnectivityHelper.checkInterNetConnect()) {
          return null;
        }
      }
      final response = await _dio.get(
        urlEndPoint,
        options: _buildOptions(headers),
      );
      return response.data;
    } on DioException catch (e) {
      return _handleException(e);
    }
  }

  // ================= POST =================
  static Future<dynamic> postData({
    required String urlEndPoint,
    required dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        urlEndPoint,
        data: body,
        options: _buildOptions(headers),
      );
      return response.data;
    } on DioException catch (e) {
      return _handleException(e);
    }
  }

  // ================= PUT =================
  static Future<dynamic> putData({
    required String urlEndPoint,
    required dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        urlEndPoint,
        data: body,
        options: _buildOptions(headers),
      );
      return response.data;
    } on DioException catch (e) {
      return _handleException(e);
    }
  }

  // ================= BACKGROUND POST =================
  static Future<dynamic> backgroundServicePost({
    required String urlEndPoint,
    required dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      // Background service mein AppConfig available nahi hota
      // SharedPreferences se baseUrl lo
      final baseUrl = await SharedPreferencesUtils.getString(
        key: PreferencesName.baseUrl,
      );

      final mergedHeaders = <String, dynamic>{...header};
      if (headers != null) mergedHeaders.addAll(headers);

      final tempDio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          headers: mergedHeaders,
        ),
      );
      final response = await tempDio.post(urlEndPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return _handleException(e);
    }
  }

  // ================= POST WITH FILE =================
  // throwOnNetworkError = true  -> net ki problem par DioException throw hogi
  //                               (offline sync ise use karta hai)
  // throwOnNetworkError = false -> purana behaviour (baaki screens ke liye)
  static Future<dynamic> postDataWithFile({
    required String urlEndPoint,
    required Map<String, dynamic> body,
    required List<ImageRequestObject> imageRequestObject,
    Map<String, dynamic>? headers,
    bool throwOnNetworkError = false,
  }) async {
    try {
      final formData = FormData.fromMap(body);

      for (var element in imageRequestObject) {
        final path = element.path ?? "";
        final key = element.key ?? "";
        if (path.isEmpty || key.isEmpty) continue;

        // Already server pe hai (http url) -> sirf text field bhejo
        if (path.startsWith("http")) {
          formData.fields.add(MapEntry(key, path));
          continue;
        }

        // Extension se sahi type nikalo (.pdf, .jpg, .png, .doc)
        final mime = lookupMimeType(path)?.split('/');

        formData.files.add(
          MapEntry(
            key,
            await MultipartFile.fromFile(
              path,
              contentType: (mime != null && mime.length == 2)
                  ? DioMediaType(mime[0], mime[1])
                  : null, // type na mile to bhi file jayegi
            ),
          ),
        );
      }

      final fileHeaders = <String, dynamic>{
        "Content-Type": "multipart/form-data",
      };
      if (headers != null) fileHeaders.addAll(headers);

      final response = await _dio.post(
        urlEndPoint,
        data: formData,
        options: Options(headers: fileHeaders),
      );
      return response.data;
    } on DioException catch (e) {
      // Net ki problem hai aur caller ne maanga hai -> throw karo
      if (throwOnNetworkError && _isNetworkError(e)) rethrow;
      return _handleException(e);
    }
  }

  // ================= NETWORK ERROR CHECK =================
  // Ye error internet ki wajah se aaya ya nahi?
  static bool _isNetworkError(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError ||
        (e.type == DioExceptionType.unknown && e.error is SocketException);
  }

  // ================= COOKIE =================
  static void updateCookie(Response response) {
    final rawCookie = response.headers.value('set-cookie');
    if (rawCookie != null) {
      final index = rawCookie.indexOf(';');
      header['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  // ================= EXCEPTION HANDLER =================
  static dynamic _handleException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        log("TimeoutException: ${e.message}");
        break;
      case DioExceptionType.connectionError:
        log("SocketException: ${e.message}");
        break;
      default:
        log("Unhandled DioException: ${e.message}");
    }
    // Server ka error response bhi return hoga
    return e.response?.data ?? e.message;
  }

  // ================= FILE COMPRESS =================
  // FIX: PNG / non-jpg file par crash nahi hoga, original path wapas milega
  static Future<String> fileCompress({required File file}) async {
    final filePath = file.path;
    final lastIndex = filePath.toLowerCase().lastIndexOf(RegExp(r'\.jp'));
    if (lastIndex == -1) return filePath;

    final splitted = filePath.substring(0, lastIndex);
    final outPath = '${splitted}_out${filePath.substring(lastIndex)}';
    final result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      outPath,
      quality: 70,
    );
    return result?.path ?? filePath;
  }
}

class ImageRequestObject {
  String? name; // display label for the UI
  String? key; // multipart form field key
  String? path; // local file path or existing http url

  ImageRequestObject({this.name, this.key, this.path});
}