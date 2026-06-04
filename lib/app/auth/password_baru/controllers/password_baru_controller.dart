// password_baru_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class PasswordBaruController
    extends GetxController {

  final passwordBaruController =
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

  Future<void>
      simpanPasswordBaru() async {

    try {

      isLoading.value = true;

      if (passwordBaruController
          .text
          .isEmpty) {

        Get.snackbar(
          "Peringatan",
          "Password baru wajib diisi",
        );

        return;
      }

      if (konfirmasiPasswordController
              .text !=
          passwordBaruController
              .text) {

        Get.snackbar(
          "Peringatan",
          "Konfirmasi password tidak cocok",
        );

        return;
      }

      // API BACKEND
      // reset password

      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );

      Get.snackbar(
        "Berhasil",
        "Password berhasil diperbarui",
        backgroundColor:
            Colors.green,
        colorText:
            Colors.white,
      );

      Get.offAllNamed(
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

  @override
  void onClose() {

    passwordBaruController
        .dispose();

    konfirmasiPasswordController
        .dispose();

    super.onClose();
  }
}