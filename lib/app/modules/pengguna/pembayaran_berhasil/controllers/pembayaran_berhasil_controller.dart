// pembayaran_berhasil_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class PembayaranBerhasilController
    extends GetxController {

  RxString orderId =
      "".obs;

  RxString tipe =
      "".obs;

  RxString judul =
      "".obs;

  RxString subtitle =
      "".obs;

  RxString buttonText =
      "".obs;

  @override
  void onInit() {
    super.onInit();

    getData();
  }

  void getData() {

    final data =
        Get.arguments;

    if (data != null) {

      orderId.value =
          data["order_id"] ?? "";

      tipe.value =
          data["tipe"] ?? "";

      judul.value =
          data["judul"] ??
              "Pembayaran Berhasil";

      subtitle.value =
          data["subtitle"] ??
              "";

      buttonText.value =
          data["button"] ??
              "Lanjut";
    }
  }

  void kembali() {

    Get.back();
  }

  void lanjut() {

    if (tipe.value ==
        "produk") {

      Get.offAllNamed(
        Routes.PRODUK_ANYAMAN,
      );

    } else {

      Get.offAllNamed(
        Routes.JADWAL_SAYA,
      );
    }
  }

  void kembaliKeBeranda() {

    Get.offAllNamed(
      Routes.HALAMAN_UTAMA,
    );
  }
}