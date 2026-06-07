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
}
