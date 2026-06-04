import 'package:get/get.dart';

import '../controllers/konfirmasi_pembayaran_controller.dart';

class KonfirmasiPembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KonfirmasiPembayaranController>(
      () => KonfirmasiPembayaranController(),
    );
  }
}
