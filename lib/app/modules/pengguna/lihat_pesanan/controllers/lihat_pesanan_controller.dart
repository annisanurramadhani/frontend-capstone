import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class LihatPesananController
    extends GetxController {
  RxBool isLoading = false.obs;

  RxList pesananList = [].obs;

  @override
  void onInit() {
    super.onInit();

    loadPesanan();
  }

  Future<void> loadPesanan() async {
    try {
      isLoading.value = true;

      final response =
          await PenggunaService
              .getRiwayatPembelian();

      if (response["success"] == true) {
        pesananList.assignAll(
          response["pesanan"],
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}