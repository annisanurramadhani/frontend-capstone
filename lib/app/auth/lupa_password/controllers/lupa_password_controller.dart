// lupa_password_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LupaPasswordController
    extends GetxController {

  final emailController =
      TextEditingController();

  void kirimOtp() {

    Get.toNamed(
      Routes.OTP_LUPA_PASSWORD,
    );
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