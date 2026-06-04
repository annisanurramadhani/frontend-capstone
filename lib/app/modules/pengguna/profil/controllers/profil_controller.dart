// profil_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class ProfilController extends GetxController {
  RxBool isLoading = false.obs;

  RxMap<String, dynamic> user = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();

    getProfil();
  }

  Future<void> getProfil() async {
    try {
      isLoading.value = true;

      // API BACKEND
      // ambil data profil user

      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void keEditProfil() {
    Get.toNamed(Routes.EDIT_PROFIL);
  }

  void keSertifikat() {
    Get.toNamed(Routes.SERTIFIKAT);
  }

  void keRiwayatAktivitas() {
    Get.toNamed(Routes.RIWAYAT_AKTIVITAS);
  }

  void keluar() {
    Get.defaultDialog(
      title: "Keluar",

      middleText: "Apakah Anda yakin ingin keluar?",

      radius: 20,

      textCancel: "Tidak",

      textConfirm: "Ya",

      confirmTextColor: Colors.white,

      buttonColor: const Color(0xFF5A3116),

      onConfirm: () async {
        // HAPUS TOKEN
        // HAPUS SESSION
        // HAPUS STORAGE

        Get.offAllNamed(Routes.SPLASH);
      },
    );
  }
}
