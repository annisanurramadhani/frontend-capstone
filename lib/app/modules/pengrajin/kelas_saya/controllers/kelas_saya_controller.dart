import 'package:get/get.dart';

import '../../../../data/services/pengrajin_service.dart';

class KelasSayaController extends GetxController {
  RxBool isLoading = false.obs;

  RxList kelasSaya = [].obs;

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;

      final response =
          await PengrajinService.getKelasSaya();

      if (response["success"] == true) {
        kelasSaya.assignAll(
          response["data"],
        );
      } else {
        Get.snackbar(
          "Gagal",
          response["message"] ??
              "Gagal memuat data",
        );
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

  Future<void> refreshData() async {
    await loadData();
  }
}