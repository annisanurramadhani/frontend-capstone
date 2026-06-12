import 'package:get/get.dart';

import '../controllers/pesan_pelatihan_controller.dart';

class PesanPelatihanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesanPelatihanController>(() => PesanPelatihanController());
  }
}
