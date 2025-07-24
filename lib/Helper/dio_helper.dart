import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
 
class DioHelper {
  static String baseUrl = "http://192.168.43.116:8000";
  static String baseUrlApi = "$baseUrl/api/";

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrlApi,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        HttpHeaders.acceptHeader: "application/json",
      },
    ),
  );

  // ✅ Custom exception wrapper
  static Exception handleDioError(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return TimeoutException('Connection timed out');
      } else if (error.type == DioExceptionType.badResponse) {
        return HttpException(
            'Server responded with error: ${error.response?.statusCode}');
      } else if (error.type == DioExceptionType.connectionError) {
        return SocketException('Connection failed: ${error.message}');
      } else if (error.type == DioExceptionType.cancel) {
        return Exception('Request was cancelled');
      } else {
        return Exception('Unexpected Dio error: ${error.message}');
      }
    } else if (error is SocketException) {
      return SocketException('No internet connection');
    } else {
      return Exception('Unknown error: $error');
    }
  }

  // ✅ GET with exception handled
  static Future<Response> getData({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
  }) async {
    try {
     
      return await _dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: params,
      );
    } catch (error) {
      print("❌ Dio GET Error: $error");
      throw handleDioError(error);
    }
  }

  // ✅ POST with exception handled
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? postData,
    Map<String, String>? headers,
  }) async {
    try {
    
      _dio.options.headers.addAll(headers ?? {});
      return await _dio.post(url, data: postData);
    } catch (error) {
      print("❌ Dio POST Error: $error");
      throw handleDioError(error);
    }
  }

  // ✅ Multipart with exception handled
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
    } catch (error) {
      print("❌ Dio Multipart Error: $error");
      throw handleDioError(error);
    }
  }
}
