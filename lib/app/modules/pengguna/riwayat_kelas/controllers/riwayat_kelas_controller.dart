// riwayat_kelas_controller.dart

import 'package:get/get.dart';

class RiwayatKelasController
    extends GetxController {

  RxList riwayatKelas = [].obs;

  @override
  void onInit() {
    super.onInit();

    getRiwayatKelas();
  }

  void getRiwayatKelas() async {

    // nanti ambil dari API

  }

  void beriReview({
    required dynamic kelas,
  }) {

    Get.snackbar(
      "Review",
      "Terima kasih sudah memberi review",
    );
  }

  void keDetailKelas(
    dynamic kelas,
  ) {

    Get.toNamed(
      '/detail-kelas',

      arguments: kelas,
    );
  }
}