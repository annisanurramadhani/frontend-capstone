// splash_controller.dart

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController
    extends GetxController {

  void goToMasuk() {

    Get.toNamed(
      Routes.MASUK,
    );
  }

  void goToDaftar() {

    Get.toNamed(
      Routes.DAFTAR,
    );
  }
}