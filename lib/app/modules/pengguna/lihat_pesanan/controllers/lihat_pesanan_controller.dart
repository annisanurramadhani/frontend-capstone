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

      print("===== RESPONSE RIWAYAT =====");
      print(response);
      print("============================");

      if (response["success"] == true) {
        pesananList.assignAll(response["pesanan"]);
        filteredPesanan.assignAll(response["pesanan"]);

        print("Jumlah Pesanan : ${filteredPesanan.length}");

        if (response["pesanan"].isNotEmpty) {
          final detailPesanan = response["pesanan"][0]["detailPesanan"];

          if (detailPesanan != null && detailPesanan.isNotEmpty) {
            final firstProduk = detailPesanan[0]["produk"];

            print("===== DEBUG FOTO =====");
            print("PRODUK : $firstProduk");
            print("FOTO VALUE : ${firstProduk?["foto"]}");
            print("=======================");
          }
        }
      }
    } catch (e) {
      print(e);
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