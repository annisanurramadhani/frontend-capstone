// detail_produk_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class DetailProdukController
    extends GetxController {

  RxInt jumlah = 1.obs;

  RxMap produk = {}.obs;

  @override
  void onInit() {
    super.onInit();

    getDetailProduk();
  }

  void getDetailProduk() {

    // data dari halaman sebelumnya

    produk.value =
        Get.arguments ?? {};
  }

  void tambahJumlah() {

    jumlah.value++;
  }

  void kurangJumlah() {

    if (jumlah.value > 1) {

      jumlah.value--;
    }
  }

  int get hargaProduk {

    return produk["harga"] ?? 0;
  }

  int get totalHarga {

    return hargaProduk *
        jumlah.value;
  }

  String formatRupiah(
    int angka,
  ) {

    return "Rp ${angka.toString().replaceAllMapped(
      RegExp(
        r'(\d{1,3})(?=(\d{3})+(?!\d))',
      ),
      (Match m) => '${m[1]}.',
    )}";
  }

  void pilihPembayaran() {

    Get.toNamed(
      Routes.PEMBAYARAN_PRODUK,

      arguments: {
        "produk": produk,
        "jumlah": jumlah.value,
        "total": totalHarga,
      },
    );
  }
}