import 'package:get/get.dart';

import '../controllers/produk_anyaman_controller.dart';

class ProdukAnyamanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProdukAnyamanController>(
      () => ProdukAnyamanController(),
    );
  }
}
