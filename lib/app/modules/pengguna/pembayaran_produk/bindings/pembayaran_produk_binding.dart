import 'package:get/get.dart';

import '../controllers/pembayaran_produk_controller.dart';

class PembayaranProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PembayaranProdukController>(
      () => PembayaranProdukController(),
    );
  }
}
