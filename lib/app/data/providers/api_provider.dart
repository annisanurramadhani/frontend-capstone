import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  // HP ASLI
  static const String mobileUrl = "http://192.168.18.72:3000/api/auth";

  // CHROME / WEB / LOKAL
  static const String localUrl = "http://localhost:3000/api/auth";

  // PILIH BASE URL
  //static const String baseUrl = mobileUrl;
  static const String baseUrl = localUrl;

  // LOGIN
  static Future<http.Response> login(String email, String password) async {
    return await http.post(
      Uri.parse("$baseUrl/login"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email, "password": password}),
    );
  }

  // VERIFY OTP
  static Future<http.Response> verifyOtp(String email, String otp) async {
    return await http.post(
      Uri.parse("$baseUrl/verify-otp"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email, "otp": otp}),
    );
  }

  // RESEND OTP
  static Future<http.Response> resendOtp(String email) async {
    return await http.post(
      Uri.parse("$baseUrl/resend-otp"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email}),
    );
  }

  // REGISTER
  static Future<http.Response> register(
    String name,
    String email,
    String password,
  ) async {
    return await http.post(
      Uri.parse("$baseUrl/register"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"name": name, "email": email, "password": password}),
    );
  }

  // REQUEST RESET PASSWORD
  static Future<http.Response> requestResetPassword(String email) async {
    return await http.post(
      Uri.parse("$baseUrl/request-reset-password"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email}),
    );
  }

  // RESET PASSWORD
  static Future<http.Response> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    return await http.post(
      Uri.parse("$baseUrl/reset-password"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      }),
    );
  }
}
