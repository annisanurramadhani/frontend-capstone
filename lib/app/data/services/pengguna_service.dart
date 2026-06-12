import 'dart:convert';

import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../providers/api_provider.dart';

class PenggunaService {
  static final box = GetStorage();

  // GET PROFILE
  static Future<dynamic> getProfile() async {
    final token = box.read("token");

    final response = await ApiProvider.getProfile(token);

    return jsonDecode(response.body);
  }

  // UPDATE PROFILE
  static Future<dynamic> updateProfile({
    required String name,
    required String email,
    required String password,
    File? photo,
  }) async {
    final token = box.read("token");

    final response = await ApiProvider.updateProfile(
      token: token,

      name: name,

      email: email,

      password: password,

      photo: photo,
    );

    final data = jsonDecode(response.body);

    // UPDATE STORAGE
    if (data['success'] == true) {
      box.write("user", data['user']);
    }

    return data;
  }

  // GET VIDEO TUTORIAL
  static Future<dynamic> getTutorialVideos() async {
    final response = await ApiProvider.getTutorialVideos();

    return jsonDecode(response.body);
  }
  // GET PENGRAJIN

  static Future<dynamic> getPengrajin() async {
    final response = await ApiProvider.getPengrajin();

    return jsonDecode(response.body);
  }
  // GET KELAS

  static Future<Map<String, dynamic>> getKelas() async {
    try {
      final response = await ApiProvider.getKelas();

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // =====================
  // CREATE BOOKING
  // =====================
  static Future<Map<String, dynamic>> createBooking({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await ApiProvider.createBooking(data: data);

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> checkStatusBayar(String orderId) async {
    try {
      final response = await ApiProvider.checkStatusBayar(orderId);
      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
  // GET RIWAYAT BOOKING

  static Future<Map<String, dynamic>> getRiwayatBooking() async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.getRiwayatBooking(token);

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // GET JADWAL KELAS
  static Future<Map<String, dynamic>> getJadwalKelas() async {
    try {
      final token = box.read("token");

      print("================================");
      print("TOKEN DI SERVICE:");
      print(token);
      print("================================");

      final response = await ApiProvider.getJadwalKelas(token);

      print("================================");
      print("STATUS CODE:");
      print(response.statusCode);

      print("BODY:");
      print(response.body);
      print("================================");

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // CREATE REVIEW
  static Future<Map<String, dynamic>> createReview({
    required String bookingId,
    required String pengrajinId,
    required int rating,
    required String ulasan,
  }) async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.createReview(
        token: token,
        data: {
          "bookingId": bookingId,
          "pengrajinId": pengrajinId,
          "rating": rating,
          "ulasan": ulasan,
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
