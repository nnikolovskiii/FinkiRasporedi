import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_app/domain/models/login_request_model.dart';
import 'package:simple_app/domain/models/register_request_model.dart';

import '../domain/models/login_response_model.dart';
import '../domain/models/register_response_model.dart';

class AuthService {
  static const String baseUrl = 'https://localhost:7069/api/auth';

  static Future<bool> login(LoginRequestModel model) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      final loginResponse = loginResponseJson(response.body);
      await _saveLoginDetails(loginResponse);
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    final response = await http.post(Uri.parse('$baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()));

    return registerResponseJson(response.body);
  }

  static Future<void> logout() async {
    // Perform logout logic, clear stored user data
    await _clearLoginDetails();
  }

  static Future<void> _saveLoginDetails(
      LoginResponseModel loginResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('login_details', jsonEncode(loginResponse.toJson()));
  }

  static Future<void> _clearLoginDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_details');
  }

  static Future<Map<String, dynamic>?> getLoggedInUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? loginDetailsString = prefs.getString('login_details');
    if (loginDetailsString != null) {
      final Map<String, dynamic> loginDetails =
      jsonDecode(loginDetailsString);
      return loginDetails;
    }
    return null;
  }
}
