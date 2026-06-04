// pilih_jadwal_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class PilihJadwalController
    extends GetxController {

  RxBool isLoading =
      false.obs;

  RxMap<String, dynamic>
      pengrajin =
      <String, dynamic>{}.obs;

  RxMap<String, dynamic>
      selectedTanggal =
      <String, dynamic>{}.obs;

  RxMap<String, dynamic>
      selectedJam =
      <String, dynamic>{}.obs;

  RxList<dynamic> tanggalList =
      <dynamic>[].obs;

  RxList<dynamic> jamList =
      <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

    getData();
  }

  Future<void> getData() async {

    try {

      isLoading.value = true;

      final data =
          Get.arguments;

      if (data != null) {

        pengrajin.value =
            Map<String, dynamic>.from(
          data,
        );
      }

      // API BACKEND
      // ambil data tanggal & jam

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      tanggalList.assignAll([
        {
          "hari":
              "Sen",
          "tanggal":
              "20 Mei",
        },

        {
          "hari":
              "Sel",
          "tanggal":
              "21 Mei",
        },

        {
          "hari":
              "Rab",
          "tanggal":
              "22 Mei",
        },

        {
          "hari":
              "Kam",
          "tanggal":
              "23 Mei",
        },

      ]);

      jamList.assignAll([
        {
          "jam":
              "09.00 - 11.00",
          "kursi":
              "5",
        },

        {
          "jam":
              "13.00 - 15.00",
          "kursi":
              "3",
        },

        {
          "jam":
              "16.00 - 18.00",
          "kursi":
              "2",
        },

      ]);

      selectedTanggal.value =
          tanggalList.first;

      selectedJam.value =
          jamList.first;
    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {

      isLoading.value = false;
    }
  }

  void pilihTanggal(
    dynamic data,
  ) {

    selectedTanggal.value =
        data;
  }

  void pilihJam(
    dynamic data,
  ) {

    selectedJam.value =
        data;
  }

  void kembali() {

    Get.back();
  }

  void lihatProfil() {

    Get.back();
  }

  void lanjutKonfirmasi() {

    Get.toNamed(
      Routes.KONFIRMASI_PEMBAYARAN,

      arguments: {
        "pengrajin":
            pengrajin,

        "tanggal":
            selectedTanggal,

        "jam":
            selectedJam,
      },
    );
  }
}