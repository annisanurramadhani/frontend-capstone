import 'package:get/get.dart';
import '../../../../data/services/pengguna_service.dart';

class ProdukAnyamanController extends GetxController {
  RxBool isLoading = true.obs;

  RxList produkList = [].obs;
  RxList allProduk = [].obs;

  RxList topProduk = [].obs;

  @override
  void onInit() {
    super.onInit();
    getProduk();
    getTopProduk();
  }

  Future<void> getProduk() async {
    try {
      isLoading.value = true;

      final response = await PenggunaService.getProduk();

      if (response["success"] == true) {
        produkList.assignAll(response["produk"] ?? []);
        allProduk.assignAll(response["produk"] ?? []);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTopProduk() async {
    try {
      final response = await PenggunaService.getTopProduk();

      print("=== TOP PRODUK ===");
      print(response);

      if (response["success"] == true) {
        topProduk.assignAll(response["top3Produk"] ?? []);
        print(topProduk);
      }
    } catch (e) {
      print(e);
    }
  }

  void searchProduk(String keyword) {
    if (keyword.isEmpty) {
      produkList.assignAll(allProduk);
      return;
    }

    final hasil = allProduk.where((item) {
      final nama = (item["namaProduk"] ?? "").toString().toLowerCase();

      return nama.contains(keyword.toLowerCase());
    }).toList();

    produkList.assignAll(hasil);
  }
}
