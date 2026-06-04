// tahapan_kelas_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class TahapanKelasController
    extends GetxController {

  RxInt currentStep =
      0.obs;

  RxMap<String, dynamic>
      pengrajin =
      <String, dynamic>{}.obs;

  final List<Map<String, dynamic>>
      tahapanList = [

    {
      "title":
          "Pilih Jadwal",

      "subtitle":
          "Tentukan jadwal kelas yang tersedia.",

      "icon":
          "calendar",
    },

    {
      "title":
          "Konfirmasi",

      "subtitle":
          "Periksa kembali detail kelas.",

      "icon":
          "check",
    },

    {
      "title":
          "Pembayaran",

      "subtitle":
          "Lakukan pembayaran kelas.",

      "icon":
          "payment",
    },

    {
      "title":
          "Kelas Dimulai",

      "subtitle":
          "Ikuti kelas bersama pengrajin.",

      "icon":
          "school",
    },

  ];

  @override
  void onInit() {
    super.onInit();

    getDataPengrajin();
  }

  void getDataPengrajin() {

    final data =
        Get.arguments;

    if (data != null) {

      pengrajin.value =
          Map<String, dynamic>.from(
        data,
      );
    }
  }

  void kembali() {

    Get.back();
  }

  void lanjutPilihJadwal() {

    Get.toNamed(
      Routes.PILIH_JADWAL,
      arguments: pengrajin,
    );
  }
}