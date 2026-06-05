// lupa_password_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class LupaPasswordController extends GetxController {
  final emailController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> kirimOtp() async {
    try {
      isLoading.value = true;

      // VALIDASI EMAIL
      if (emailController.text.trim().isEmpty) {
        Get.snackbar("Peringatan", "Email wajib diisi");

        return;
      }

      // VALIDASI FORMAT EMAIL
      if (!emailController.text.trim().contains("@")) {
        Get.snackbar("Peringatan", "Format email tidak valid");

        return;
      }

      // REQUEST RESET PASSWORD
      final response = await AuthService.requestResetPassword(
        emailController.text.trim(),
      );

      // SUCCESS
      if (response['success'] == true) {
        Get.snackbar("Berhasil", response['message']);

        // PINDAH KE OTP
        Get.toNamed(
          Routes.OTP_LUPA_PASSWORD,

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

  void kembali() {
    Get.back();
  }

  @override
  void onClose() {
    emailController.dispose();

    super.onClose();
  }
}
