// otp_lupa_password_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class OtpLupaPasswordController extends GetxController {
  final otp1Controller = TextEditingController();

  final otp2Controller = TextEditingController();

  final otp3Controller = TextEditingController();

  final otp4Controller = TextEditingController();

  final otp5Controller = TextEditingController();

  final otp6Controller = TextEditingController();

  RxBool isLoading = false.obs;

  late String email;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments['email'];
  }

  Future<void> verifikasiOtp() async {
    try {
      isLoading.value = true;

      final otp =
          otp1Controller.text +
          otp2Controller.text +
          otp3Controller.text +
          otp4Controller.text +
          otp5Controller.text +
          otp6Controller.text;

      // VALIDASI OTP
      if (otp.length < 6) {
        Get.snackbar("Peringatan", "Kode OTP harus 6 digit");

        return;
      }

      // LANGSUNG KE HALAMAN PASSWORD BARU
      // OTP DICEK SAAT RESET PASSWORD

      Get.toNamed(
        Routes.PASSWORD_BARU,

        arguments: {"email": email, "otp": otp},
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> kirimUlangOtp() async {
    try {
      isLoading.value = true;

      final response = await AuthService.requestResetPassword(email);

      if (response['success'] == true) {
        Get.snackbar("Berhasil", "Kode OTP berhasil dikirim ulang");
      } else {
        Get.snackbar("Error", response['message']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otp1Controller.dispose();

    otp2Controller.dispose();

    otp3Controller.dispose();

    otp4Controller.dispose();

    otp5Controller.dispose();

    otp6Controller.dispose();

    super.onClose();
  }
}
