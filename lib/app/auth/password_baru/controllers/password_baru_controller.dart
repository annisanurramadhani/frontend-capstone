// password_baru_controller.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';

import '../../../routes/app_pages.dart';

class PasswordBaruController extends GetxController {
  final passwordBaruController = TextEditingController();

  final konfirmasiPasswordController = TextEditingController();

  RxBool isPasswordHidden = true.obs;

  RxBool isKonfirmasiPasswordHidden = true.obs;

  RxBool isLoading = false.obs;

  late String email;

  late String otp;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments['email'];

    otp = Get.arguments['otp'];
  }

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleKonfirmasiPassword() {
    isKonfirmasiPasswordHidden.value = !isKonfirmasiPasswordHidden.value;
  }

  Future<void> simpanPasswordBaru() async {
    try {
      isLoading.value = true;

      // VALIDASI PASSWORD
      if (passwordBaruController.text.isEmpty) {
        Get.snackbar("Peringatan", "Password baru wajib diisi");

        return;
      }

      // VALIDASI MINIMAL
      if (passwordBaruController.text.length < 6) {
        Get.snackbar("Peringatan", "Password minimal 6 karakter");

        return;
      }

      // VALIDASI KONFIRMASI
      if (konfirmasiPasswordController.text != passwordBaruController.text) {
        Get.snackbar("Peringatan", "Konfirmasi password tidak cocok");

        return;
      }

      // RESET PASSWORD
      final response = await AuthService.resetPassword(
        email,
        otp,
        passwordBaruController.text,
      );

      print(response);

      // SUCCESS
      if (response['success'] == true) {
        Get.snackbar(
          "Berhasil",
          response['message'],

          backgroundColor: Colors.green,

          colorText: Colors.white,
        );

        // PINDAH HALAMAN
        Get.offAllNamed(Routes.MASUK);
      } else {
        Get.snackbar("Error", response['message']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
