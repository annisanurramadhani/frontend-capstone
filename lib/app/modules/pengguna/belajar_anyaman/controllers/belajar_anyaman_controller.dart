import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class BelajarAnyamanController extends GetxController {
  RxBool isLoading = false.obs;

  RxList videos = [].obs;

  @override
  void onInit() {
    super.onInit();

    getVideos();
  }

  Future<void> getVideos() async {
    try {
      isLoading.value = true;

      final response = await PenggunaService.getTutorialVideos();

      if (response['success'] == true) {
        videos.value = response['videos'];
      } else {
        Get.snackbar("Error", response['message']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
