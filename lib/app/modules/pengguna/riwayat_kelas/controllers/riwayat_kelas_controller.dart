import 'package:get/get.dart';
import '../../../../data/services/pengguna_service.dart';

class RiwayatKelasController extends GetxController {
  RxBool isLoading = true.obs;

  RxList bookings = [].obs;

  @override
  void onInit() {
    super.onInit();
    getRiwayat();
  }

  Future<void> getRiwayat() async {
    try {
      isLoading.value = true;

      final response = await PenggunaService.getRiwayatBooking();

      if (response["success"] == true) {
        bookings.assignAll(response["bookings"] ?? []);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
