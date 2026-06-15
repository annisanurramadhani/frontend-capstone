import 'package:get/get.dart';
import '../../../../data/services/pengguna_service.dart';

class ProdukAnyamanController extends GetxController {
  RxBool isLoading = true.obs;

  RxList produkList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getProduk();
  }

  Future<void> getProduk() async {
    try {
      isLoading.value = true;

      final response =
          await PenggunaService.getProduk();

      if (response["success"] == true) {
        produkList.assignAll(
          response["produk"] ?? [],
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}