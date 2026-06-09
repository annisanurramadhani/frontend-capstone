// edit_profil_controller.dart

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../data/services/auth_service.dart';

import '../../../../data/services/pengguna_service.dart';

class EditProfilController extends GetxController {
  RxBool isLoading = false.obs;

  RxBool isPasswordHidden = true.obs;

  final namaController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);

  RxString photoUrl = "".obs;

  @override
  void onInit() {
    super.onInit();

    getProfil();
  }

  Future<void> getProfil() async {
    try {
      final user = AuthService.getUser();

      namaController.text = user["name"] ?? "";

      emailController.text = user["email"] ?? "";

      photoUrl.value = user["photo"] ?? "";
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // PILIH FOTO
  Future<void> pilihFoto() async {
    try {
      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void kembali() {
    Get.back();
  }

  Future<void> simpanPerubahan() async {
    try {
      isLoading.value = true;

      // VALIDASI NAMA
      if (namaController.text.trim().isEmpty) {
        isLoading.value = false;

        Get.snackbar("Peringatan", "Nama wajib diisi");

        return;
      }

      // VALIDASI EMAIL
      if (emailController.text.trim().isEmpty) {
        isLoading.value = false;

        Get.snackbar("Peringatan", "Email wajib diisi");

        return;
      }

      // VALIDASI PASSWORD
      if (passwordController.text.isNotEmpty &&
          passwordController.text.length < 6) {
        isLoading.value = false;

        Get.snackbar("Peringatan", "Password minimal 6 karakter");

        return;
      }

      // UPDATE PROFILE
      final response = await PenggunaService.updateProfile(
        name: namaController.text.trim(),

        email: emailController.text.trim(),

        password: passwordController.text,

        photo: selectedImage.value,
      );

      print(response);

      // SUCCESS
      if (response['success'] == true) {
        // UPDATE STORAGE
        AuthService.box.write("user", response['user']);

        // CLOSE LOADING
        isLoading.value = false;

        // KEMBALI KE PROFILE
        Get.back(result: true);

        // SNACKBAR
        Get.snackbar(
          "Berhasil",
          response['message'],

          backgroundColor: Colors.green,

          colorText: Colors.white,
        );
      } else {
        isLoading.value = false;

        Get.snackbar("Error", response['message']);
      }
    } catch (e) {
      isLoading.value = false;

      Get.snackbar("Error", e.toString());
    }
  }
}
