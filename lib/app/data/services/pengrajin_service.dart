import 'dart:convert';

import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../providers/api_provider.dart';

class PengrajinService {
  static final box = GetStorage();

  // DASHBOARD
  static Future<Map<String, dynamic>> getDashboard() async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.getDashboardPengrajin(token);

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // KELAS SAYA
  static Future<Map<String, dynamic>> getKelasSaya() async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.getKelasSaya(token);

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // PROFILE
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.getProfilePengrajin(token);

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // UPDATE PROFILE
  static Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String alamat,
    required String noTelpon,
    required String pengalaman,
    required String deskripsi,
    File? photo,
  }) async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.updateProfilePengrajin(
        token: token,
        name: name,
        alamat: alamat,
        noTelpon: noTelpon,
        pengalaman: pengalaman,
        deskripsi: deskripsi,
        photo: photo,
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // GET NOTIFIKASI
  static Future<Map<String, dynamic>> getNotifikasi() async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.getNotifikasiPengrajin(token);

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}