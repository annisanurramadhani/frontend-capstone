// materi_anyaman_controller.dart

import 'package:get/get.dart';

class MateriAnyamanController
    extends GetxController {

  RxBool isLoading =
      false.obs;

  RxList<dynamic> materiList =
      <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

    getMateri();
  }

  Future<void> getMateri() async {

    try {

      isLoading.value = true;

      // API BACKEND
      // ambil data materi dari backend

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      materiList.assignAll([
        {
          "title":
              "Pengenalan Anyaman",
          "durasi":
              "15 Menit",
          "thumbnail":
              "assets/images/materi1.jpg",
        },

        {
          "title":
              "Teknik Dasar Anyaman",
          "durasi":
              "25 Menit",
          "thumbnail":
              "assets/images/materi2.jpg",
        },

        {
          "title":
              "Pola Anyaman",
          "durasi":
              "40 Menit",
          "thumbnail":
              "assets/images/materi3.jpg",
        },

        {
          "title":
              "Finishing Produk",
          "durasi":
              "20 Menit",
          "thumbnail":
              "assets/images/materi4.jpg",
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

  void detailMateri(
    dynamic data,
  ) {

    // nanti ke detail/video materi
  }
}