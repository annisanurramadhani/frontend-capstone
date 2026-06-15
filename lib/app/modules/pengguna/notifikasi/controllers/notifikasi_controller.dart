import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class NotifikasiController extends GetxController {
  RxBool isLoading = false.obs;

  RxList notifikasiList = [].obs;

  @override
  void onInit() {
    super.onInit();

    getNotifikasi();
  }

  Future<void> getNotifikasi() async {
    try {
      isLoading.value = true;

      final response =
          await PenggunaService.getNotifikasi();

      if (response["success"] == true) {
        notifikasiList.assignAll(
          response["data"],
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}