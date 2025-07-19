import 'dart:io';
import 'package:dio/dio.dart';

class DioHelper {
  static String baseUrl = "http://192.168.1.15:8000";
  static String baseUrlApi = "$baseUrl/api/";

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrlApi,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {HttpHeaders.acceptHeader: "application/json"},
    ),
    
  );

  // GET request
  static Future<Response> getData({
  required String url,
  Map<String, String>? headers,
  Map<String, dynamic>? params, // Add this parameter for query params
}) async {
  try {
    return await _dio.get(
      url,
      options: Options(headers: headers),
      queryParameters: params, // Pass the query parameters here
    );
  } catch (e) {
    rethrow;
  }
}

  // POST request
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? postData,
    Map<String, dynamic>? headers,
  }) async {
    _dio.options.headers.addAll(headers ?? {});

    return await _dio.post(url, data: postData);
  }

  // Multipart request
  static Future<Response> postMultipart({
    required String url,
    required File file,
    required String fieldName,
    Map<String, String>? headers,
  }) async {
    try {
      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(file.path),
      });

      return await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }
}
