import 'package:get/get.dart';

import '../controllers/belajar_anyaman_controller.dart';

class BelajarAnyamanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BelajarAnyamanController>(
      () => BelajarAnyamanController(),
    );
  }
}
