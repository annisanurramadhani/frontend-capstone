// masuk_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class MasukController
    extends GetxController {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  RxBool isPasswordHidden =
      true.obs;

  RxBool isLoading =
      false.obs;

  void togglePassword() {

    isPasswordHidden.value =
        !isPasswordHidden.value;
  }

  Future<void> masuk() async {

    try {

      isLoading.value = true;

      // VALIDASI
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

      // API BACKEND
      // nanti sambungkan backend

      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );

      Get.toNamed(
        Routes.OTP_LOGIN,
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

  Future<void>
      masukDenganGoogle() async {

    try {

      isLoading.value = true;

      // LOGIN GOOGLE

      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );

      Get.offAllNamed(
        Routes.HALAMAN_UTAMA,
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

  void lupaPassword() {

    Get.toNamed(
      Routes.LUPA_PASSWORD,
    );
  }

  void goToDaftar() {

    Get.toNamed(
      Routes.DAFTAR,
    );
  }

  @override
  void onClose() {

    emailController.dispose();

    passwordController.dispose();

    super.onClose();
  }
}