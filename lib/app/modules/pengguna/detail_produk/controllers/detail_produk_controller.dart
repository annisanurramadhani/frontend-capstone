import 'package:get/get.dart';
import '../../../../data/services/pengguna_service.dart';
import '../../produk_anyaman/controllers/produk_anyaman_controller.dart';

class DetailProdukController extends GetxController {
  RxBool isLoading = true.obs;

  RxMap produk = {}.obs;

  @override
  void onInit() {
    super.onInit();

    final id = Get.arguments;

    getDetailProduk(id);
  }

  Future<void> getDetailProduk(String id) async {
    try {
      isLoading.value = true;

      final response = await PenggunaService.getDetailProduk(id);

      if (response["success"] == true) {
        produk.value = response["produk"];
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    if (Get.isRegistered<ProdukAnyamanController>()) {
      Get.find<ProdukAnyamanController>().getTopViewProduk();
    }

    super.onClose();
  }
}
