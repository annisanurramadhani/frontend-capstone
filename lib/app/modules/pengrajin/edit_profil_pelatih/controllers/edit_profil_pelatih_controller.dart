import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/services/pengrajin_service.dart';

class EditProfilPelatihController extends GetxController {
  RxBool isLoading = false.obs;
  RxString fotoUrl = "".obs;

  final namaC = TextEditingController();
  final alamatC = TextEditingController();
  final noHpC = TextEditingController();
  final pengalamanC = TextEditingController();
  final deskripsiC = TextEditingController();

  final ImagePicker picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      final response = await PengrajinService.getProfile();

      if (response["success"] == true) {
        final data = response["data"] ?? {};
        final profile = data["pengrajinProfile"] ?? {};

        namaC.text       = (data["name"] ?? "").toString();
        alamatC.text     = (profile["alamat"] ?? "").toString();
        noHpC.text       = (profile["noTelpon"] ?? "").toString();
        pengalamanC.text = (profile["pengalaman"] ?? "").toString();
        deskripsiC.text  = (profile["deskripsi"] ?? "").toString();
        fotoUrl.value    = (profile["photo"] ?? "").toString();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pilihFoto() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> simpan() async {
    try {
      if (namaC.text.trim().isEmpty) {
        Get.snackbar("Peringatan", "Nama wajib diisi");
        return;
      }
      if (alamatC.text.trim().isEmpty) {
        Get.snackbar("Peringatan", "Alamat wajib diisi");
        return;
      }

      isLoading.value = true;

      final response = await PengrajinService.updateProfile(
        name:       namaC.text.trim(),
        alamat:     alamatC.text.trim(),
        noTelpon:   noHpC.text.trim(),
        pengalaman: pengalamanC.text.trim(),
        deskripsi:  deskripsiC.text.trim(),
        photo:      selectedImage.value,
      );

      if (response["success"] == true) {
        Get.snackbar(
          "Berhasil",
          response["message"] ?? "Profil berhasil diperbarui",
          backgroundColor: const Color(0xFF3E2723),
          colorText: Colors.white,
          borderRadius: 14,
          margin: const EdgeInsets.all(16),
        );
        Get.back(result: true);
      } else {
        Get.snackbar(
          "Gagal",
          response["message"] ?? "Gagal memperbarui profil",
          backgroundColor: const Color(0xFF3E2723),
          colorText: Colors.white,
          borderRadius: 14,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    namaC.dispose();
    alamatC.dispose();
    noHpC.dispose();
    pengalamanC.dispose();
    deskripsiC.dispose();
    super.onClose();
  }
}