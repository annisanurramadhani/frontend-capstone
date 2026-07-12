import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class OtpLoginController extends GetxController {
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();
  final otp5Controller = TextEditingController();
  final otp6Controller = TextEditingController();

  final box = GetStorage();

  RxBool isLoading = false.obs;
  RxBool isResending = false.obs;

  RxInt countdown = 60.obs;
  RxBool canResend = false.obs;

  Timer? _timer;

  late String email;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments?['email'] ?? "";

    _startCountdown();
  }

  @override
  void onClose() {
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    otp5Controller.dispose();
    otp6Controller.dispose();

    _timer?.cancel();

    super.onClose();
  }

  void _startCountdown() {
    canResend.value = false;
    countdown.value = 60;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value <= 1) {
        timer.cancel();
        countdown.value = 0;
        canResend.value = true;
      } else {
        countdown.value--;
      }
    });
  }

  void _clearOtpFields() {
    otp1Controller.clear();
    otp2Controller.clear();
    otp3Controller.clear();
    otp4Controller.clear();
    otp5Controller.clear();
    otp6Controller.clear();
  }

  Future<void> verifikasiOtp() async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;

      final otp =
          otp1Controller.text +
          otp2Controller.text +
          otp3Controller.text +
          otp4Controller.text +
          otp5Controller.text +
          otp6Controller.text;

      if (otp.length < 6) {
        Get.snackbar(
          "Peringatan",
          "Kode OTP harus 6 digit",
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      final response = await AuthService.verifyOtp(email, otp);

      if (response["success"] == true) {
        Get.snackbar(
          "Berhasil",
          "Verifikasi OTP berhasil. Silakan login.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );

        Get.offAllNamed(Routes.MASUK, arguments: {"email": email});
      } else {
        _clearOtpFields();

        Get.snackbar(
          "OTP Salah",
          response["message"] ?? "Kode OTP tidak valid",
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> kirimUlangOtp() async {
    if (!canResend.value) return;

    try {
      isResending.value = true;

      final response = await AuthService.resendOtp(email);

      if (response["success"] == true) {
        _clearOtpFields();
        _startCountdown();

        Get.snackbar(
          "Berhasil",
          response["message"] ?? "Kode OTP baru telah dikirim",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Gagal",
          response["message"] ?? "Gagal mengirim ulang OTP",
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isResending.value = false;
    }
  }
}
