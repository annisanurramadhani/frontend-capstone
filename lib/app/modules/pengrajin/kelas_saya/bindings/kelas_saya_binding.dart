import 'package:get/get.dart';

import '../controllers/kelas_saya_controller.dart';

class KelasSayaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KelasSayaController>(
      () => KelasSayaController(),
    );
  }
}
