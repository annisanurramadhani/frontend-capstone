import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class BeriRatingController extends GetxController {
  final ulasanController = TextEditingController();

  RxInt rating = 5.obs;

  RxBool isLoading = false.obs;

  late String bookingId;

  late String pengrajinId;

  late String pengrajinNama;

  @override
  void onInit() {
    super.onInit();

    bookingId = Get.arguments["bookingId"];

    pengrajinId = Get.arguments["pengrajinId"];

    pengrajinNama = Get.arguments["pengrajinNama"];
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
