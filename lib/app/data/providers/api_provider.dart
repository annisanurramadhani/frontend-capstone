import 'dart:convert';

import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class ApiProvider {
  // MOBILE
  static const String mobileBaseUrl = "http://10.223.117.201:3000";

  static const String mobileAuthUrl = "$mobileBaseUrl/api/auth";

  static const String mobilePenggunaUrl = "$mobileBaseUrl/api/pengguna";

  // WEB
  static const String webBaseUrl = "http://localhost:3000";

  static const String webAuthUrl = "$webBaseUrl/api/auth";

  static const String webPenggunaUrl = "$webBaseUrl/api/pengguna";

  // AUTO URL
  static String get baseUrl => kIsWeb ? webBaseUrl : mobileBaseUrl;

  static String get authUrl => kIsWeb ? webAuthUrl : mobileAuthUrl;

  static String get penggunaUrl => kIsWeb ? webPenggunaUrl : mobilePenggunaUrl;

  // LOGIN
  static Future<http.Response> login(String email, String password) async {
    return await http.post(
      Uri.parse("$authUrl/login"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email, "password": password}),
    );
  }

  // VERIFY OTP
  static Future<http.Response> verifyOtp(String email, String otp) async {
    return await http.post(
      Uri.parse("$authUrl/verify-otp"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email, "otp": otp}),
    );
  }

  // RESEND OTP
  static Future<http.Response> resendOtp(String email) async {
    return await http.post(
      Uri.parse("$authUrl/resend-otp"),

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
      Uri.parse("$authUrl/register"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"name": name, "email": email, "password": password}),
    );
  }

  // REQUEST RESET PASSWORD
  static Future<http.Response> requestResetPassword(String email) async {
    return await http.post(
      Uri.parse("$authUrl/request-reset-password"),

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
      Uri.parse("$authUrl/reset-password"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      }),
    );
  }

  // GET PROFILE
  static Future<http.Response> getProfile(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/profile"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },
    );
  }

  // UPDATE PROFILE
  static Future<http.Response> updateProfile({
    required String token,
    required String name,
    required String email,
    required String password,
    File? photo,
  }) async {
    var request = http.MultipartRequest(
      "PUT",

      Uri.parse("$penggunaUrl/profile"),
    );

    // HEADER
    request.headers["Authorization"] = "Bearer $token";

    // FIELD
    request.fields["name"] = name;

    request.fields["email"] = email;

    if (password.isNotEmpty) {
      request.fields["password"] = password;
    }

    // PHOTO
    if (photo != null) {
      request.files.add(await http.MultipartFile.fromPath("photo", photo.path));
    }

    final streamedResponse = await request.send();

    return await http.Response.fromStream(streamedResponse);
  }
  // GET VIDEO TUTORIAL

  static Future<http.Response> getTutorialVideos() async {
    return await http.get(
      Uri.parse("$penggunaUrl/tutorial-video"),

      headers: {"Content-Type": "application/json"},
    );
  }

  // GET PENGRAJIN
  static Future<http.Response> getPengrajin() async {
    return await http.get(
      Uri.parse("$penggunaUrl/pengrajin"),
      headers: {"Content-Type": "application/json"},
    );
  }
}
