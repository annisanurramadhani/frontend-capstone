// edit_profil_controller.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EditProfilController
    extends GetxController {

  RxBool isLoading =
      false.obs;

  RxBool isPasswordHidden =
      true.obs;

  final namaController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();

    getProfil();
  }

  Future<void> getProfil() async {

    try {

      isLoading.value =
          true;

      // API BACKEND
      // ambil data profil

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );

    } finally {

      isLoading.value =
          false;
    }
  }

  void togglePassword() {

    isPasswordHidden.value =
        !isPasswordHidden.value;
  }

  void kembali() {

    Get.back();
  }

  Future<void>
      simpanPerubahan() async {

    try {

      isLoading.value =
          true;

      // API BACKEND
      // update profil user

      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );

      Get.snackbar(
        "Berhasil",
        "Profil berhasil diperbarui",
      );

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );

    } finally {

      isLoading.value =
          false;
    }
  }

  @override
  void onClose() {

    namaController.dispose();

    emailController.dispose();

    passwordController.dispose();

    super.onClose();
  }
}