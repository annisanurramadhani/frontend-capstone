// jadwal_saya_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class JadwalSayaController
    extends GetxController {

  RxInt selectedTab = 0.obs;

  RxList jadwalList = [].obs;

  RxList riwayatList = [].obs;

  @override
  void onInit() {
    super.onInit();

    getJadwal();
  }

  void getJadwal() {

    // nanti ambil dari API

    jadwalList.value = [];

    riwayatList.value = [];
  }

  void gantiTab(
    int index,
  ) {

    selectedTab.value =
        index;
  }

  void lihatDetail(
    dynamic data,
  ) {

    Get.toNamed(
      Routes.DETAIL_KELAS,
      arguments: data,
    );
  }

  void keBeranda() {

    Get.offAllNamed(
      Routes.HALAMAN_UTAMA,
    );
  }

  void keProfil() {

    Get.offAllNamed(
      Routes.PROFIL,
    );
  }

  void keCariKelas() {

    Get.offAllNamed(
      Routes.BELAJAR_ANYAMAN,
    );
  }
}