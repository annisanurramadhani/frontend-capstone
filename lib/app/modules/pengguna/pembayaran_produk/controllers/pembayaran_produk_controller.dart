// pembayaran_produk_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class PembayaranProdukController
    extends GetxController {

  RxString metodePembayaran =
      "QRIS".obs;

  void pilihMetode(
    String metode,
  ) {

    metodePembayaran.value =
        metode;
  }

  void bayarSekarang() {

    Get.toNamed(
      Routes.PEMBAYARAN_BERHASIL,

      arguments: {

        "tipe": "produk",

        "order_id":
            "ORD-PRODUK-001",

        "judul":
            "Pesanan Berhasil",

        "subtitle":
            "Produk berhasil dipesan dan sedang diproses.",

        "button":
            "Lihat Pesanan",
      },
    );
  }
}