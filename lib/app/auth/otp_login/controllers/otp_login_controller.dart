// otp_login_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class OtpLoginController
    extends GetxController {

  final otp1Controller =
      TextEditingController();

  final otp2Controller =
      TextEditingController();

  final otp3Controller =
      TextEditingController();

  final otp4Controller =
      TextEditingController();

  RxBool isLoading =
      false.obs;

  Future<void> verifikasiOtp() async {

    try {

      isLoading.value = true;

      final otp =
          otp1Controller.text +
          otp2Controller.text +
          otp3Controller.text +
          otp4Controller.text;

      if (otp.length < 4) {

        Get.snackbar(
          "Peringatan",
          "Kode OTP harus lengkap",
        );

        return;
      }

      // API BACKEND
      // verifikasi OTP login

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

  Future<void> kirimUlangOtp() async {

    // API BACKEND
    // resend OTP

    Get.snackbar(
      "Berhasil",
      "Kode OTP berhasil dikirim ulang",
    );
  }

  @override
  void onClose() {

    otp1Controller.dispose();

    otp2Controller.dispose();

    otp3Controller.dispose();

    otp4Controller.dispose();

    super.onClose();
  }
}