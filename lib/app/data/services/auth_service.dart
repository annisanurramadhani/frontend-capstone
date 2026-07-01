import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../providers/api_provider.dart';

class AuthService {
  static final box = GetStorage();

  // GOOGLE LOGIN
  static Future<dynamic> googleLogin(
    String idToken, {
    String role = "pengguna",
  }) async {
    final response = await ApiProvider.googleLogin(idToken, role: role);

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      box.write("token", data["token"] ?? "");
      box.write("user", data["user"] ?? {});
    }

    return data;
  }

  // LOGIN
  static Future<dynamic> login(String email, String password) async {
    final response = await ApiProvider.login(email, password);

    return jsonDecode(response.body);
  }

  // VERIFY OTP
  static Future<dynamic> verifyOtp(String email, String otp) async {
    final response = await ApiProvider.verifyOtp(email, otp);

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      box.write("token", data['token'] ?? "");

      box.write("user", data['user'] ?? {});
    }

    return data;
  }

  // RESEND OTP
  static Future<dynamic> resendOtp(String email) async {
    final response = await ApiProvider.resendOtp(email);

    return jsonDecode(response.body);
  }

  // REGISTER
  static Future<dynamic> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await ApiProvider.register(name, email, password);

    return jsonDecode(response.body);
  }

  // REQUEST RESET PASSWORD
  static Future<dynamic> requestResetPassword(String email) async {
    final response = await ApiProvider.requestResetPassword(email);

    return jsonDecode(response.body);
  }

  // RESET PASSWORD
  static Future<dynamic> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    final response = await ApiProvider.resetPassword(email, otp, newPassword);

    return jsonDecode(response.body);
  }

  // LOGOUT
  static Future<void> logout() async {
    await box.remove("token");

    await box.remove("user");
  }

  // GET TOKEN
  static String getToken() {
    return box.read("token") ?? "";
  }

  // GET USER
  static dynamic getUser() {
    return box.read("user") ?? {};
  }

  // CHECK LOGIN
  static bool isLogin() {
    final token = box.read("token");

    return token != null && token != "";
  }
}
