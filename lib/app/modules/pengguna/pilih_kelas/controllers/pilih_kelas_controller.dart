import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class PilihKelasController extends GetxController {
  RxBool isLoading = false.obs;

  RxList kelas = [].obs;

  @override
  void onInit() {
    super.onInit();

    getKelas();
  }

  Future<void> getKelas() async {
    try {
      isLoading.value = true;

      final response = await PenggunaService.getKelas();

      if (response["success"] == true) {
        kelas.value = response["kelas"];
      } else {
        Get.snackbar("Error", response["message"]);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
