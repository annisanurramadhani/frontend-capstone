// belajar_anyaman_controller.dart

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
class BelajarAnyamanController
    extends GetxController {

  void kembali() {
    Get.back();
  }

  void keMateriAnyaman() {

    Get.toNamed(
      Routes.MATERI_ANYAMAN,
    );
  }
}