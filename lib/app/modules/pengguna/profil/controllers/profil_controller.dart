// profil_controller.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/services/auth_service.dart';

import '../../../../data/services/pengguna_service.dart';

import '../../../../routes/app_pages.dart';

class ProfilController extends GetxController {
  RxBool isLoading = false.obs;

  RxMap<String, dynamic> user = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();

    getProfil();
  }

  void kembali() {
    Get.back();
  }

  Future<void> getProfil() async {
    try {
      isLoading.value = true;

      // API PROFILE
      final response = await PenggunaService.getProfile();

      // SUCCESS
      if (response['success'] == true) {
        user.value = response['user'];
      } else {
        Get.snackbar("Error", response['message']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> keEditProfil() async {
    final result = await Get.toNamed(Routes.EDIT_PROFIL);

    print(result);

    // REFRESH PROFILE
    if (result == true) {
      await getProfil();

      user.refresh();
    }
  }

  void keSertifikat() {
    Get.toNamed(Routes.SERTIFIKAT);
  }

  void keRiwayatAktivitas() {
    Get.toNamed(Routes.RIWAYAT_AKTIVITAS);
  }

  Future<void> keluar() async {
    Get.defaultDialog(
      title: "Keluar",

      middleText: "Apakah Anda yakin ingin keluar?",

      radius: 20,

      textCancel: "Tidak",

      textConfirm: "Ya",

      confirmTextColor: Colors.white,

      buttonColor: const Color(0xFF5A3116),

      onConfirm: () async {
        try {
          Get.back();

          isLoading.value = true;

          final response = await PenggunaService.logout();

          if (response["success"] == true) {
            await AuthService.logout();

            Get.offAllNamed(Routes.SPLASH);

            Get.snackbar("Berhasil", response["message"]);
          } else {
            Get.snackbar("Error", response["message"]);
          }
        } catch (e) {
          Get.snackbar("Error", e.toString());
        } finally {
          isLoading.value = false;
        }
      },
    );
  }
}
