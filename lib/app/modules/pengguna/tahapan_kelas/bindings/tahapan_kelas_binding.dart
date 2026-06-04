import 'package:get/get.dart';

import '../controllers/tahapan_kelas_controller.dart';

class TahapanKelasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TahapanKelasController>(
      () => TahapanKelasController(),
    );
  }
}
