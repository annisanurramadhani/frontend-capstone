// detail_kelas_controller.dart

import 'package:get/get.dart';

class DetailKelasController
    extends GetxController {

  RxMap detailKelas = {}.obs;

  @override
  void onInit() {
    super.onInit();

    getDetailKelas();
  }

  void getDetailKelas() {

    // nanti ambil dari API

    detailKelas.value =
        Get.arguments ?? {};
  }

  void kembali() {

    Get.back();
  }
}