// pemesanan_produk_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class PemesananProdukController extends GetxController {
  late Map produk;

  final formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();

  final noTelponController = TextEditingController();

  final alamatController = TextEditingController();

  RxString kecamatan = "".obs;

  RxInt ongkir = 0.obs;

  final List<String> daftarKecamatan = [
    // Kabupaten Tegal
    "Adiwerna",
    "Balapulang",
    "Bojong",
    "Bumijawa",
    "Dukuhturi",
    "Dukuhwaru",
    "Jatinegara",
    "Kedungbanteng",
    "Kramat",
    "Lebaksiu",
    "Margasari",
    "Pagerbarang",
    "Pangkah",
    "Slawi",
    "Suradadi",
    "Talang",
    "Tarub",
    "Warureja",

    // Kota Tegal
    "Margadana",
    "Tegal Barat",
    "Tegal Selatan",
    "Tegal Timur",
  ];

  final Map<String, int> ongkirMap = {
    "Slawi": 10000,
    "Adiwerna": 10000,
    "Talang": 10000,
    "Dukuhturi": 10000,
    "Tegal Barat": 10000,
    "Tegal Timur": 10000,
    "Tegal Selatan": 10000,
    "Margadana": 10000,

    "Kramat": 12000,
    "Pangkah": 12000,
    "Dukuhwaru": 12000,
    "Tarub": 12000,

    "Warureja": 15000,
    "Suradadi": 15000,
    "Lebaksiu": 15000,
    "Jatinegara": 15000,
    "Kedungbanteng": 15000,
    "Pagerbarang": 15000,
    "Margasari": 15000,

    "Balapulang": 18000,
    "Bojong": 18000,

    "Bumijawa": 20000,
  };

  @override
  void onInit() {
    super.onInit();

    produk = Get.arguments;
  }

  @override
  void onClose() {
    namaController.dispose();
    noTelponController.dispose();
    alamatController.dispose();

    super.onClose();
  }

  void pilihKecamatan(String value) {
    kecamatan.value = value;

    ongkir.value = ongkirMap[value] ?? 0;
  }

  int get hargaProduk {
    return produk["harga"] ?? 0;
  }

  int get totalPembayaran {
    return hargaProduk + ongkir.value;
  }

  void lanjutPembayaran() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (kecamatan.value.isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Silakan pilih kecamatan",
      );
      return;
    }

    Get.toNamed(
      Routes.PEMBAYARAN_PRODUK,
      arguments: {
        "produk": produk,
        "nama": namaController.text,
        "noTelpon": noTelponController.text,
        "alamat": alamatController.text,
        "kecamatan": kecamatan.value,
        "ongkir": ongkir.value,
        "total": totalPembayaran,
      },
    );
  }
}