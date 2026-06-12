// otp_login_controller.dart

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

  // FOCUS OTP
  final focus1 = FocusNode();

  final focus2 = FocusNode();

  final focus3 = FocusNode();

  final focus4 = FocusNode();

  final focus5 = FocusNode();

  final focus6 = FocusNode();

  final box = GetStorage();

  RxBool isLoading = false.obs;

  RxBool isResending = false.obs;

  // COUNTDOWN
  RxInt countdown = 60.obs;

  RxBool canResend = false.obs;

  Timer? _timer;

  late String email;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments['email'];

    _startCountdown();

    // AUTO FOCUS
    Future.delayed(const Duration(milliseconds: 300), () {
      FocusScope.of(Get.context!).requestFocus(focus1);
    });
  }

  @override
  void onClose() {
    otp1Controller.dispose();

    otp2Controller.dispose();

    otp3Controller.dispose();

    otp4Controller.dispose();

    otp5Controller.dispose();

    otp6Controller.dispose();

    focus1.dispose();

    focus2.dispose();

    focus3.dispose();

    focus4.dispose();

    focus5.dispose();

    focus6.dispose();

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

    FocusScope.of(Get.context!).requestFocus(focus1);
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

      // VALIDASI
      if (otp.length < 6) {
        Get.snackbar(
          "Peringatan",
          "Kode OTP harus 6 digit",

          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      // API VERIFY OTP
      final response = await AuthService.verifyOtp(email, otp);

      // SUCCESS
      if (response['success'] == true) {
        box.write("token", response['token']);

        box.write("user", response['user']);

        Get.snackbar(
          "Berhasil",
          response['message'],

          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAllNamed(Routes.HALAMAN_UTAMA);
      } else {
        _clearOtpFields();

        Get.snackbar(
          "OTP Salah",

          response['message'] ?? "Kode OTP tidak valid",

          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> kirimUlangOtp() async {
    if (!canResend.value) return;

    try {
      isResending.value = true;

      final response = await AuthService.resendOtp(email);

      if (response['success'] == true) {
        _clearOtpFields();

        _startCountdown();

        Get.snackbar(
          "Berhasil",

          response['message'] ?? "Kode OTP baru telah dikirim",

          snackPosition: SnackPosition.BOTTOM,

          backgroundColor: const Color(0xFF8B5E3C),

          colorText: Colors.white,

          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          "Gagal",

          response['message'] ?? "Gagal mengirim ulang OTP",

          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isResending.value = false;
    }
  }
}
