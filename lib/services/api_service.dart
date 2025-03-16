// 1. API SERVICE (lib/services/api_service.dart)
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/attribute.dart';

class ApiService {
  static Future<ApiResponse> getFormAttributes() async {
    final response = await http.get(
      Uri.parse('http://team.dev.helpabode.com:54292/api/wempro/flutter-dev/coding-test-2025/'),
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}