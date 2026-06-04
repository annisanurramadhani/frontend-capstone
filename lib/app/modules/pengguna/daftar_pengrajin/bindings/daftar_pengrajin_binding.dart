import 'package:get/get.dart';

import '../controllers/daftar_pengrajin_controller.dart';

class DaftarPengrajinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarPengrajinController>(
      () => DaftarPengrajinController(),
    );
  }
}
