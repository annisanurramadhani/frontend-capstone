// profil_pengrajin_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class ProfilPengrajinController
    extends GetxController {

  RxBool isLoading =
      false.obs;

  RxMap<String, dynamic>
      pengrajin =
      <String, dynamic>{}.obs;

  RxList<dynamic> ulasanList =
      <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

    getDetailPengrajin();
  }

  Future<void>
      getDetailPengrajin() async {

    try {

      isLoading.value = true;

      final data =
          Get.arguments;

      // API BACKEND
      // ambil detail pengrajin berdasarkan id

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      pengrajin.value = {
        "id":
            data["id"],
        "nama":
            data["nama"],
        "lokasi":
            data["lokasi"],
        "rating":
            data["rating"],
        "foto":
            data["foto"],
        "spesialis":
            "Anyaman Bambu",
        "pengalaman":
            "20+ Tahun",
        "siswa":
            "350+",
        "tentang":
            "Pengrajin anyaman bambu berpengalaman dan aktif mengajarkan teknik anyaman tradisional.",
      };

      ulasanList.assignAll([
        {
          "nama":
              "Dewi Lestari",
          "rating":
              "5.0",
          "ulasan":
              "Penjelasan sangat jelas dan mudah dipahami.",
        },

        {
          "nama":
              "Rina",
          "rating":
              "4.9",
          "ulasan":
              "Materi sangat lengkap dan pengajarnya ramah.",
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

  void pesanKelas() {

    Get.toNamed(
      Routes.TAHAPAN_KELAS,
      arguments: pengrajin,
    );
  }
}