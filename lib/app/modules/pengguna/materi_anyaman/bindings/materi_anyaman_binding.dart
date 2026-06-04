import 'package:get/get.dart';

import '../controllers/materi_anyaman_controller.dart';

class MateriAnyamanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MateriAnyamanController>(
      () => MateriAnyamanController(),
    );
  }
}
