// daftar_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class DaftarController
    extends GetxController {

  final namaController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final konfirmasiPasswordController =
      TextEditingController();

  RxBool isPasswordHidden =
      true.obs;

  RxBool isKonfirmasiPasswordHidden =
      true.obs;

  RxBool isLoading =
      false.obs;

  void togglePassword() {

    isPasswordHidden.value =
        !isPasswordHidden.value;
  }

  void toggleKonfirmasiPassword() {

    isKonfirmasiPasswordHidden.value =
        !isKonfirmasiPasswordHidden
            .value;
  }

  Future<void> daftar() async {

    try {

      isLoading.value = true;

      // VALIDASI
      if (namaController.text
          .trim()
          .isEmpty) {

        Get.snackbar(
          "Peringatan",
          "Nama lengkap wajib diisi",
        );

        return;
      }

      if (emailController.text
          .trim()
          .isEmpty) {

        Get.snackbar(
          "Peringatan",
          "Email wajib diisi",
        );

        return;
      }

      if (passwordController.text
          .isEmpty) {

        Get.snackbar(
          "Peringatan",
          "Password wajib diisi",
        );

        return;
      }

      if (konfirmasiPasswordController
              .text !=
          passwordController.text) {

        Get.snackbar(
          "Peringatan",
          "Konfirmasi password tidak cocok",
        );

        return;
      }

      // API BACKEND
      // nanti sambungkan backend

      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );

      Get.snackbar(
        "Berhasil",
        "Akun berhasil dibuat",
        backgroundColor:
            Colors.green,
        colorText:
            Colors.white,
      );

      Get.offNamed(
        Routes.MASUK,
      );
    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {

      isLoading.value = false;
    }
  }

  void goToLogin() {

    Get.toNamed(
      Routes.MASUK,
    );
  }

  @override
  void onClose() {

    namaController.dispose();

    emailController.dispose();

    passwordController.dispose();

    konfirmasiPasswordController
        .dispose();

    super.onClose();
  }
}