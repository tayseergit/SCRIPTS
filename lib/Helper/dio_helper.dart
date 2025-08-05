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
        options: Options(headers: headers, validateStatus: (status) {
            // Allow Dio to return 422, 401, etc. as normal responses
            return status != null && status <= 500;
          },),
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

      return await _dio.post(
        url,
        data: postData,
        options: Options(
          headers: headers,
          validateStatus: (status) {
             return status != null && status <= 500;
          },
        ),
      );
    } catch (error) {
      print("❌ Dio POST Error: $error");
      rethrow;
    }
  }
static Future<Response> postFormData({
  required String url,
  required FormData postData,
  Map<String, String>? headers,
}) async {
  try {
    return await _dio.post(
      url,
      data: postData,
      options: Options(
        headers: headers,
        contentType: Headers.formUrlEncodedContentType,
         validateStatus: (status) {
            // Allow Dio to return 422, 401, etc. as normal responses
            return status != null && status < 500;
          },
      ),
    );

      
  } on DioError catch (dioError) {
    if (dioError.response != null) {
      print("❌ DioError: Status ${dioError.response?.statusCode}");
      print("❌ Response data: ${dioError.response?.data}");
    } else {
      print("❌ DioError: ${dioError.message}");
    }
    rethrow;
  } catch (error) {
    print("❌ Unexpected error: $error");
    rethrow;
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
