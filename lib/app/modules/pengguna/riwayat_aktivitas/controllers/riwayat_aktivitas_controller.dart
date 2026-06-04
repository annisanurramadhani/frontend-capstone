import 'package:get/get.dart';

class RiwayatAktivitasController
    extends GetxController {

  RxBool isLoading =
      false.obs;

  RxList<dynamic>
      aktivitasList =
      <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

    getRiwayatAktivitas();
  }

  Future<void>
      getRiwayatAktivitas() async {

    try {

      isLoading.value =
          true;

      // API BACKEND
      // GET RIWAYAT AKTIVITAS USER

      /*
      contoh response:

      [
        {
          "id": 1,
          "aktivitas":
              "Pembayaran kelas berhasil",
          "waktu":
              "20 Mei 2026 • 10:20",
          "icon":
              "payment"
        }
      ]
      */

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

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