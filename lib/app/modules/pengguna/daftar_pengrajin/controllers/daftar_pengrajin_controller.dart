// daftar_pengrajin_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class DaftarPengrajinController
    extends GetxController {

  RxBool isLoading =
      false.obs;

  RxList<dynamic> pengrajinList =
      <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

    getPengrajin();
  }

  Future<void> getPengrajin() async {

    try {

      isLoading.value = true;

      // API BACKEND
      // ambil data pengrajin dari backend

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      pengrajinList.assignAll([
        {
          "id": 1,
          "nama":
              "Ibu Sari",
          "lokasi":
              "Jepara, Jawa Tengah",
          "rating":
              "4.9",
          "foto":
              "assets/images/pengrajin1.jpg",
        },

        {
          "id": 2,
          "nama":
              "Pak Budi",
          "lokasi":
              "Tasikmalaya",
          "rating":
              "4.8",
          "foto":
              "assets/images/pengrajin2.jpg",
        },

        {
          "id": 3,
          "nama":
              "Bu Rina",
          "lokasi":
              "Bali",
          "rating":
              "5.0",
          "foto":
              "assets/images/pengrajin3.jpg",
        },

      ]);
    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {

      isLoading.value = false;
    }
  }

  void kembali() {

    Get.back();
  }

  void keProfilPengrajin(
    dynamic data,
  ) {

    Get.toNamed(
      Routes.PROFIL_PENGRAJIN,
      arguments: data,
    );
  }
}