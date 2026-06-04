// produk_anyaman_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class ProdukAnyamanController
    extends GetxController {

  RxList produkList = [].obs;

  RxBool isLoading =
      false.obs;

  @override
  void onInit() {
    super.onInit();

    getProduk();
  }

  void getProduk() async {

    try {

      isLoading.value =
          true;

      // nanti ambil dari API backend

      /*
      
      contoh response API

      [
        {
          "id": 1,
          "nama": "Keranjang Bambu",
          "harga": 85000,
          "gambar": "https://..."
        }
      ]

      */

    } catch (e) {

      Get.snackbar(
        "Error",
        "Gagal mengambil produk",
      );

    } finally {

      isLoading.value =
          false;
    }
  }

  void lihatDetail(
    dynamic produk,
  ) {

    Get.toNamed(
      Routes.DETAIL_PRODUK,

      arguments: produk,
    );
  }
}