import 'package:get/get.dart';
import '../controllers/pembayaran_pelatihan_controller.dart';

class PembayaranPelatihanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PembayaranPelatihanController>(
      () => PembayaranPelatihanController(),
    );
  }
}
