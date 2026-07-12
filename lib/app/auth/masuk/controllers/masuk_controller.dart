import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class MasukController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    GoogleSignIn.instance.initialize(
      serverClientId:
          '807830659888-3nubedb4eh6a1l7hhflalj0o89401t66.apps.googleusercontent.com',
    );
  }

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> masuk() async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;

      if (emailController.text.trim().isEmpty) {
        Get.snackbar(
          "Peringatan",
          "Email wajib diisi",
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      if (passwordController.text.isEmpty) {
        Get.snackbar(
          "Peringatan",
          "Password wajib diisi",
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      final response = await AuthService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response["success"] == true) {
        AuthService.box.write("token", response["token"] ?? "");
        AuthService.box.write("user", response["user"] ?? {});

        Get.snackbar(
          "Berhasil",
          response["message"] ?? "Login berhasil",
          snackPosition: SnackPosition.TOP,
        );

        final user = response["user"];

        if (user["role"] == "pengrajin") {
          Get.offAllNamed(Routes.HALAMAN_PENGRAJIN);
        } else {
          Get.offAllNamed(Routes.HALAMAN_UTAMA);
        }
      } else {
        Get.snackbar(
          "Error",
          response["message"] ?? "Login gagal",
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> masukDenganGoogle() async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;

      final GoogleSignInAccount account = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication auth = account.authentication;

      final String? idToken = auth.idToken;

      if (idToken == null) {
        throw Exception("ID Token tidak ditemukan");
      }

      final result = await AuthService.googleLogin(idToken, role: "pengguna");

      if (result["success"] == true) {
        AuthService.box.write("token", result["token"] ?? "");
        AuthService.box.write("user", result["user"] ?? {});

        Get.snackbar(
          "Berhasil",
          result["message"] ?? "Login berhasil",
          snackPosition: SnackPosition.TOP,
        );

        final user = result["user"];

        if (user["role"] == "pengrajin") {
          Get.offAllNamed(Routes.HALAMAN_PENGRAJIN);
        } else {
          Get.offAllNamed(Routes.HALAMAN_UTAMA);
        }
      } else {
        Get.snackbar(
          "Error",
          result["message"] ?? "Login gagal",
          snackPosition: SnackPosition.TOP,
        );
      }
    } on GoogleSignInException catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  void lupaPassword() => Get.toNamed(Routes.LUPA_PASSWORD);

  void goToDaftar() => Get.toNamed(Routes.DAFTAR);

  void kembali() {
    Get.back();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
