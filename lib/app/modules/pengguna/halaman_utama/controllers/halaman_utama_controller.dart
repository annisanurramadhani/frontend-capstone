// halaman_utama_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class HalamanUtamaController
    extends GetxController {

  RxBool isLoading = false.obs;

  RxList<dynamic> menuUtama =
      <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

    getMenuUtama();
  }

  Future<void> getMenuUtama() async {

    try {

      isLoading.value = true;

      // API BACKEND
      // nanti ambil dari backend

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      menuUtama.assignAll([
        {
          "title":
              "Belajar Anyaman",
          "icon":
              "assets/icons/belajar.png",
          "route":
              Routes.BELAJAR_ANYAMAN,
        },

        {
          "title":
              "Daftar Pengrajin",
          "icon":
              "assets/icons/pengrajin.png",
          "route":
              Routes.DAFTAR_PENGRAJIN,
        },

        {
          "title":
              "Produk Anyaman",
          "icon":
              "assets/icons/produk.png",
          "route":
              Routes.PRODUK_ANYAMAN,
        },

        {
          "title":
              "Jadwal Saya",
          "icon":
              "assets/icons/jadwal.png",
          "route":
              Routes.JADWAL_SAYA,
        },

        {
          "title":
              "Riwayat Kelas",
          "icon":
              "assets/icons/riwayat.png",
          "route":
              Routes.RIWAYAT_KELAS,
        },

        {
          "title":
              "Profil",
          "icon":
              "assets/icons/profil.png",
          "route":
              Routes.PROFIL,
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

  void pindahHalaman(
    String route,
  ) {

    Get.toNamed(route);
  }
}