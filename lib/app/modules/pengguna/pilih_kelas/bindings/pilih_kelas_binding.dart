import 'package:get/get.dart';

import '../controllers/pilih_kelas_controller.dart';

class PilihKelasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PilihKelasController>(() => PilihKelasController());
  }
}
