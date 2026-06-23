import 'package:get/get.dart';

import '../controllers/notifikasi_pengrajin_controller.dart';

class NotifikasiPengrajinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifikasiPengrajinController>(
      () => NotifikasiPengrajinController(),
    );
  }
}
