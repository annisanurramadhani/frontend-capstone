import 'package:get/get.dart';

import '../controllers/edit_profil_pelatih_controller.dart';

class EditProfilPelatihBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfilPelatihController>(
      () => EditProfilPelatihController(),
    );
  }
}
