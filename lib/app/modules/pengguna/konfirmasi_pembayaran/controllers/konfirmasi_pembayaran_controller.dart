// konfirmasi_pembayaran_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class KonfirmasiPembayaranController
    extends GetxController {

  RxBool isLoading =
      false.obs;

  RxMap<String, dynamic>
      dataKelas =
      <String, dynamic>{}.obs;

  RxMap<String, dynamic>
      selectedMetode =
      <String, dynamic>{}.obs;

  RxList<dynamic>
      metodePembayaranList =
      <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

    getData();
  }

  Future<void> getData() async {

    try {

      isLoading.value =
          true;

      final data =
          Get.arguments;

      if (data != null) {

        dataKelas.value =
            Map<String, dynamic>.from(
          data,
        );
      }

      // API BACKEND
      // get metode pembayaran

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      metodePembayaranList
          .assignAll([

        {
          "id": 1,
          "nama": "QRIS",
          "subtitle":
              "Scan kode QR untuk membayar",
        },

        {
          "id": 2,
          "nama": "GoPay",
          "subtitle":
              "Bayar menggunakan saldo GoPay",
        },

        {
          "id": 3,
          "nama":
              "ShopeePay",
          "subtitle":
              "Bayar menggunakan ShopeePay",
        },

        {
          "id": 4,
          "nama":
              "Virtual Account",
          "subtitle":
              "BCA, BRI, BNI, Mandiri",
        },

      ]);

      selectedMetode.value =
          metodePembayaranList
              .first;
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

  void pilihMetode(
    dynamic data,
  ) {

    selectedMetode.value =
        data;
  }

  void kembali() {

    Get.back();
  }

  void lihatProfil() {

    Get.back();
  }

  void bayar() {

    Get.toNamed(
      Routes.PEMBAYARAN_PELATIHAN,

      arguments: {
        "kelas":
            dataKelas,

        "metode":
            selectedMetode,
      },
    );
  }
}