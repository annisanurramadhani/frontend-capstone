import 'package:get/get.dart';

import '../controllers/halaman_pengrajin_controller.dart';

class HalamanPengrajinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HalamanPengrajinController>(
      () => HalamanPengrajinController(),
    );
  }
}
