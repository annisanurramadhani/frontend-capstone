import 'package:get/get.dart';

import '../controllers/status_pengiriman_controller.dart';

class StatusPengirimanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusPengirimanController>(
      () => StatusPengirimanController(),
    );
  }
}
