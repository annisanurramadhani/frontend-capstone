import 'package:get/get.dart';

import '../controllers/profil_pelatih_controller.dart';

class ProfilPelatihBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilPelatihController>(
      () => ProfilPelatihController(),
    );
  }
}
