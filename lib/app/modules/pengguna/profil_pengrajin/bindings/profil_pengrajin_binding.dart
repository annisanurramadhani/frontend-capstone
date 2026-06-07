import 'package:get/get.dart';

import '../controllers/profil_pengrajin_controller.dart';

class ProfilPengrajinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilPengrajinController>(() => ProfilPengrajinController());
  }
}
