import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioHelper {
  static late final Dio _dio;

  static Future<void> init() async {
    final ip = dotenv.env['API_IP'];
    if (ip == null || ip.isEmpty) {
      throw Exception('❌ API_IP not found in .env file');
    }

    final baseUrl = "http://$ip:8000";
    final baseUrlApi = "$baseUrl/api/";

    _dio = Dio(
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
  }

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

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? postData,
    Map<String, String>? headers,
  }) async {
    try {
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }
      return await _dio.post(url, data: postData);
    } catch (error) {
      print("❌ Dio POST Error: $error");
      throw handleDioError(error);
    }
  }

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

  // ✅ PUT with exception handled
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? putData,
    Map<String, String>? headers,
  }) async {
    try {
      return await _dio.put(
        url,
        data: putData,
        options: Options(headers: headers),
      );
    } catch (error) {
      print("❌ Dio PUT Error: $error");
      throw handleDioError(error);
    }
  }

  // ✅ DELETE with exception handled
  static Future<Response> deleteData({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
  }) async {
    try {
      return await _dio.delete(
        url,
        options: Options(headers: headers),
        queryParameters: params,
      );
    } catch (error) {
      print("❌ Dio DELETE Error: $error");
      throw handleDioError(error);
    }
  }
}
