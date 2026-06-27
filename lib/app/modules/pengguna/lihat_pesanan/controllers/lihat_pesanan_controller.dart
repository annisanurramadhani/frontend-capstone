import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class LihatPesananController extends GetxController {
  RxBool isLoading = false.obs;

  RxList pesananList = [].obs;

  RxList filteredPesanan = [].obs;

  RxString selectedStatus = "Semua".obs;

  @override
  void onInit() {
    super.onInit();
    loadPesanan();
  }

  Future<void> loadPesanan() async {
    try {
      isLoading.value = true;

      final response = await PenggunaService.getRiwayatPembelian();

      if (response["success"] == true) {
        pesananList.assignAll(response["pesanan"]);
        filteredPesanan.assignAll(response["pesanan"]);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void pilihStatus(String status) {
    selectedStatus.value = status;

    if (status == "Semua") {
      filteredPesanan.assignAll(pesananList);
      return;
    }

    filteredPesanan.assignAll(
      pesananList.where((item) {
        final statusPesanan = (item["statusPesanan"] ?? "")
            .toString()
            .toLowerCase();

        switch (status.toLowerCase()) {
          case "diterima":
            return statusPesanan == "diterima";

          case "dikemas":
            return statusPesanan == "dikemas";

          case "dikirim":
            return statusPesanan == "dikirim";

          case "selesai":
            return statusPesanan == "selesai";

          default:
            return true;
        }
      }).toList(),
    );
  }
}
