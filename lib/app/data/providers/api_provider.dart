import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  // MOBILE
  static const String mobileBaseUrl = "http://10.223.117.201:3000";

  // WEB
  static const String webBaseUrl = "http://localhost:3000";

  // AUTO BASE URL
  static String get baseUrl => kIsWeb ? webBaseUrl : mobileBaseUrl;

  // AUTH
  static String get authUrl => "$baseUrl/api/auth";

  // PENGGUNA
  static String get penggunaUrl => "$baseUrl/api/pengguna";

  // Payment URL
  static String get paymentUrl =>
      kIsWeb ? "$webBaseUrl/api/payment" : "$mobileBaseUrl/api/payment";

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

  // GET KELAS
  static Future<http.Response> getKelas() async {
    return await http.get(
      Uri.parse("$penggunaUrl/kelas"),

      headers: {"Content-Type": "application/json"},
    );
  }
  // CREATE BOOKING

  static Future<http.Response> createBooking({
    required Map<String, dynamic> data,
  }) async {
    return await http.post(
      Uri.parse("$penggunaUrl/booking"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode(data),
    );
  }

  static Future<http.Response> checkStatusBayar(String orderId) async {
    return await http.get(
      Uri.parse("$baseUrl/api/payment/status/$orderId"),
      headers: {"Content-Type": "application/json"},
    );
  }
  // GET RIWAYAT BOOKING

  static Future<http.Response> getRiwayatBooking(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/riwayat-booking"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // GET JADWAL KELAS
  static Future<http.Response> getJadwalKelas(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/jadwal-kelas"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // CREATE REVIEW
  static Future<http.Response> createReview({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return await http.post(
      Uri.parse("$penggunaUrl/review"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data),
    );
  }
}
