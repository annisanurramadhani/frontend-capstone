import 'package:get/get.dart';

import '../controllers/lihat_pesanan_controller.dart';

class LihatPesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LihatPesananController>(
      () => LihatPesananController(),
    );
  }
}
