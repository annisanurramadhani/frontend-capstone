import 'package:get/get.dart';

import '../controllers/pemesanan_produk_controller.dart';

class PemesananProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemesananProdukController>(
      () => PemesananProdukController(),
    );
  }
}
