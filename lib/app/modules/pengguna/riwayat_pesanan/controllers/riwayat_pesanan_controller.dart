import 'package:get/get.dart';

class RiwayatPesananController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Map<String, dynamic>> riwayatPesanan =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    getRiwayatPesanan();
  }

  Future<void> getRiwayatPesanan() async {
    try {
      isLoading.value = true;

      // TODO:
      // panggil API backend disini

      // contoh:
      // final response =
      // await PesananService.getRiwayatPesanan();

      // riwayatPesanan.assignAll(response["data"]);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await getRiwayatPesanan();
  }
}