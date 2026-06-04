// notifikasi_controller.dart

import 'package:get/get.dart';

class NotifikasiController
    extends GetxController {

  RxList notifikasi = [].obs;

  @override
  void onInit() {
    super.onInit();

    getNotifikasi();
  }

  void getNotifikasi() async {

    // nanti ambil dari API backend

    /*
    
    contoh data dari backend

    [
      {
        "id": 1,
        "judul": "Pembayaran Berhasil",
        "pesan": "Pembayaran kelas berhasil dilakukan",
        "waktu": "Baru saja",
        "tipe": "pembayaran"
      }
    ]

    */

  }

  void bukaNotifikasi(
    dynamic item,
  ) {

    if (item["tipe"] ==
        "pembayaran") {

      Get.toNamed(
        '/jadwal-saya',
      );
    }

    if (item["tipe"] ==
        "jadwal") {

      Get.toNamed(
        '/jadwal-saya',
      );
    }
  }
}