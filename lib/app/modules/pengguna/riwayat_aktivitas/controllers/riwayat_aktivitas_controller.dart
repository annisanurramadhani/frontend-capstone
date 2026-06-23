import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class RiwayatAktivitasController
    extends GetxController {

  RxBool isLoading = false.obs;

  RxList aktivitas = [].obs;

  @override
  void onInit() {
    super.onInit();

    getAktivitas();
  }

  Future<void> getAktivitas() async {
    try {
      isLoading.value = true;

      final response =
          await PenggunaService
              .getAktivitas();

      if (response["success"] ==
          true) {
        aktivitas.value =
            response["data"];
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}