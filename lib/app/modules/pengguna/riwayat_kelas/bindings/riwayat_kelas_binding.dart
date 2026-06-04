import 'package:get/get.dart';

import '../controllers/riwayat_kelas_controller.dart';

class RiwayatKelasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatKelasController>(
      () => RiwayatKelasController(),
    );
  }
}
