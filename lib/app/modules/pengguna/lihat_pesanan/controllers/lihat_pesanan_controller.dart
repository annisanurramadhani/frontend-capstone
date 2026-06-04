// lihat_pesanan_controller.dart

import 'package:get/get.dart';

class LihatPesananController
    extends GetxController {

  RxBool isLoading =
      false.obs;

  RxList<dynamic>
      pesananList =
      <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

    getPesanan();
  }

  Future<void> getPesanan() async {

    try {

      isLoading.value =
          true;

      // API BACKEND
      // ambil data pesanan

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      pesananList.assignAll([
        {
          "nama":
              "Tas Anyaman",

          "harga":
              "Rp150.000",

          "status":
              "Diproses",

          "gambar":
              "assets/images/produk1.jpg",
        },

        {
          "nama":
              "Keranjang Bambu",

          "harga":
              "Rp85.000",

          "status":
              "Dikirim",

          "gambar":
              "assets/images/produk2.jpg",
        },
      ]);

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );

    } finally {

      isLoading.value =
          false;
    }
  }

  void kembali() {

    Get.back();
  }
}