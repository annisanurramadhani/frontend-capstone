// sertifikat_controller.dart

import 'package:get/get.dart';

class SertifikatController
    extends GetxController {

  RxBool isLoading =
      false.obs;

  RxList<dynamic>
      sertifikatList =
      <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

    getSertifikat();
  }

  Future<void>
      getSertifikat() async {

    try {

      isLoading.value =
          true;

      // API BACKEND
      // get sertifikat user

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );

    } finally {

      isLoading.value =
          false;
    }
  }

  void kembali() {

    Get.back();
  }

  void lihatSertifikat(
    dynamic data,
  ) {

    // buka detail sertifikat
    // Get.toNamed()

  }

  void unduhPdf(
    dynamic data,
  ) {

    // download pdf sertifikat

    Get.snackbar(
      "Berhasil",
      "Sertifikat berhasil diunduh",
    );
  }
}