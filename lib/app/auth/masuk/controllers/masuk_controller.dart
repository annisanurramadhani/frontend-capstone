import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class MasukController extends GetxController {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  RxBool isPasswordHidden = true.obs;

  RxBool isLoading = false.obs;

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> masuk() async {
    try {
      isLoading.value = true;

      // VALIDASI EMAIL
      if (emailController.text.trim().isEmpty) {
        Get.snackbar("Peringatan", "Email wajib diisi");

        return;
      }

      // VALIDASI PASSWORD
      if (passwordController.text.isEmpty) {
        Get.snackbar("Peringatan", "Password wajib diisi");

        return;
      }

      // LOGIN API
      final response = await AuthService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // SUCCESS
      if (response['success'] == true) {
        Get.snackbar("Berhasil", response['message']);

        Get.toNamed(Routes.OTP_LOGIN, arguments: {"email": response['email']});
      } else {
        Get.snackbar("Error", response['message']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> masukDenganGoogle() async {
    try {
      isLoading.value = true;

      // LOGIN GOOGLE
      await Future.delayed(const Duration(seconds: 1));

      Get.offAllNamed(Routes.HALAMAN_UTAMA);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void lupaPassword() {
    Get.toNamed(Routes.LUPA_PASSWORD);
  }

  void goToDaftar() {
    Get.toNamed(Routes.DAFTAR);
  }

  @override
  void onClose() {
    emailController.dispose();

    passwordController.dispose();

    super.onClose();
  }
}
