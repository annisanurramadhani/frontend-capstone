import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class DaftarController extends GetxController {
  final namaController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final konfirmasiPasswordController = TextEditingController();

  RxBool isPasswordHidden = true.obs;

  RxBool isKonfirmasiPasswordHidden = true.obs;

  RxBool isLoading = false.obs;

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleKonfirmasiPassword() {
    isKonfirmasiPasswordHidden.value = !isKonfirmasiPasswordHidden.value;
  }

  Future<void> daftar() async {
    try {
      isLoading.value = true;

      // VALIDASI NAMA
      if (namaController.text.trim().isEmpty) {
        Get.snackbar("Peringatan", "Nama lengkap wajib diisi");

        return;
      }

      // VALIDASI EMAIL
      if (!emailController.text.trim().contains("@")) {
        Get.snackbar("Peringatan", "Format email tidak valid");

        return;
      }

      // VALIDASI PASSWORD
      if (passwordController.text.length < 6) {
        Get.snackbar("Peringatan", "Password minimal 6 karakter");

        return;
      }

      // VALIDASI PASSWORD COCOK
      if (konfirmasiPasswordController.text != passwordController.text) {
        Get.snackbar("Peringatan", "Konfirmasi password tidak cocok");

        return;
      }

      // REGISTER API
      final response = await AuthService.register(
        namaController.text.trim(),

        emailController.text.trim(),

        passwordController.text,
      );

      // SUCCESS
      if (response['success'] == true) {
        Get.snackbar(
          "Berhasil",
          response['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offNamed(
          Routes.OTP_LOGIN,
          arguments: {"email": emailController.text.trim()},
        );
      } else {
        Get.snackbar("Error", response['message']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.toNamed(Routes.MASUK);
  }

  @override
  void onClose() {
    namaController.dispose();

    emailController.dispose();

    passwordController.dispose();

    konfirmasiPasswordController.dispose();

    super.onClose();
  }
}
