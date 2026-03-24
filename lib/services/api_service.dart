import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'auth_service.dart';

/// Central API service for all backend HTTP calls.
class ApiService {
  // ── Base URL auto-detection ──
  // Android emulator uses 10.0.2.2 to reach host localhost.
  // Windows, web, iOS simulator, and physical devices use localhost.
  // Production: set _isProduction to true and use your Render URL.
  static const bool _isProduction = false;
  static const String _prodUrl = 'https://punova-api.onrender.com/api/v1';

  static String get baseUrl {
    if (_isProduction) return _prodUrl;
    if (kIsWeb) return 'http://localhost:3000/api/v1';
    // Physical Android/iOS device: use your PC's LAN IP
    // Android emulator would use 10.0.2.2, but physical device needs real IP
    if (Platform.isAndroid || Platform.isIOS) {
      return 'http://10.58.22.232:3000/api/v1';
    }
    // Windows, macOS, Linux desktop
    return 'http://localhost:3000/api/v1';
  }

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  /// GET request with optional auth token injection.
  Future<Map<String, dynamic>> get(String endpoint) async {
    final headers = await _headers();
    final response = await http
        .get(Uri.parse('$baseUrl$endpoint'), headers: headers)
        .timeout(const Duration(seconds: 15));
    return _handleResponse(response);
  }

  /// POST request with JSON body.
  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    final headers = await _headers();
    final response = await http
        .post(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(const Duration(seconds: 15));
    return _handleResponse(response);
  }

  /// PUT request with JSON body.
  Future<Map<String, dynamic>> put(String endpoint,
      {Map<String, dynamic>? body}) async {
    final headers = await _headers();
    final response = await http
        .put(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        )
        .timeout(const Duration(seconds: 15));
    return _handleResponse(response);
  }

  /// Multipart POST for file uploads.
  Future<Map<String, dynamic>> uploadFile(
    String endpoint,
    String fieldName,
    File file, {
    Map<String, String>? fields,
  }) async {
    final token = await AuthService().getToken();
    final request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl$endpoint'));

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.files.add(await http.MultipartFile.fromPath(fieldName, file.path));

    if (fields != null) {
      request.fields.addAll(fields);
    }

    final streamedResponse =
        await request.send().timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }

  /// Build headers with content-type and optional auth token.
  Future<Map<String, String>> _headers() async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final token = await AuthService().getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  /// Parse response and handle errors.
  Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    throw ApiException(
      statusCode: response.statusCode,
      message: body['error'] ?? 'Unknown error',
    );
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}
