import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class BeriRatingController extends GetxController {
  final ulasanController = TextEditingController();

  RxInt rating = 5.obs;

  RxBool isLoading = false.obs;

  RxBool isLoadingPengrajin = false.obs;

  late String bookingId;

  late String pengrajinId;

  RxString pengrajinNama = "".obs;

  RxString pengrajinPhoto = "".obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    bookingId = args["bookingId"] ?? "";

    pengrajinId = args["pengrajinId"] ?? "";

    // Pakai dulu data dari argumen (kalau ada) supaya tidak blank sesaat
    pengrajinNama.value = args["pengrajinNama"] ?? "";

    pengrajinPhoto.value = args["pengrajinPhoto"] ?? "";

    // Tetap fetch detail pengrajin langsung dari API
    // supaya foto & nama selalu akurat tanpa bergantung halaman asal
    loadPengrajin();
  }

  Future<void> loadPengrajin() async {
    if (pengrajinId.isEmpty) return;

    try {
      isLoadingPengrajin.value = true;

      final response = await PenggunaService.getPengrajin();

      if (response["success"] == true) {
        final List daftarPengrajin = response["pengrajin"];

        final found = daftarPengrajin.firstWhere(
          (item) => item["id"] == pengrajinId,
          orElse: () => null,
        );

        if (found != null) {
          pengrajinNama.value = found["name"] ?? pengrajinNama.value;
          pengrajinPhoto.value = found["photo"] ?? pengrajinPhoto.value;
        }
      }
    } catch (e) {
      print("Gagal memuat data pengrajin: $e");
    } finally {
      isLoadingPengrajin.value = false;
    }
  }

  Future<void> submitReview() async {
    if (ulasanController.text.trim().isEmpty) {
      Get.snackbar("Peringatan", "Ulasan tidak boleh kosong");
      return;
    }

    isLoading.value = true;

    final result = await PenggunaService.createReview(
      bookingId: bookingId,
      pengrajinId: pengrajinId,
      rating: rating.value,
      ulasan: ulasanController.text.trim(),
    );

    isLoading.value = false;

    if (result["success"] == true) {
      Get.back(result: true);

      Get.snackbar("Berhasil", "Review berhasil dikirim");
    } else {
      Get.snackbar("Error", result["message"] ?? "Terjadi kesalahan");
    }
  }

  @override
  void onClose() {
    ulasanController.dispose();
    super.onClose();
  }
}