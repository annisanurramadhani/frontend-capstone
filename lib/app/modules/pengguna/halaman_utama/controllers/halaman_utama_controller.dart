import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/services/auth_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../../data/services/socket_service.dart';

class HalamanUtamaController extends GetxController {
  RxBool isLoading = false.obs;

  RxString nama = "".obs;

  RxMap<String, dynamic> user = <String, dynamic>{}.obs;

  RxList<Map<String, dynamic>> menuUtama = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    getUser();

    loadMenu();

    SocketService.connect();
  }

  @override
  void onClose() {
    SocketService.disconnect();

    super.onClose();
  }

  Future<void> getUser() async {
    try {
      isLoading.value = true;

      final data = AuthService.getUser();

      user.assignAll(data);

      nama.value = data["name"] ?? "";
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void loadMenu() {
    menuUtama.assignAll([
      {
        "title": "Belajar Anyaman",
        "icon": Icons.school_outlined,
        "route": Routes.BELAJAR_ANYAMAN,
      },
      {
        "title": "Daftar Pengrajin",
        "icon": Icons.groups_outlined,
        "route": Routes.DAFTAR_PENGRAJIN,
      },
      {
        "title": "Produk Anyaman",
        "icon": Icons.shopping_bag_outlined,
        "route": Routes.PRODUK_ANYAMAN,
      },
      {
        "title": "Sertifikat",
        "icon": Icons.workspace_premium_outlined,
        "route": Routes.SERTIFIKAT,
      },
    ]);
  }

  void pindahHalaman(String route) {
    Get.toNamed(route);
  }
}
