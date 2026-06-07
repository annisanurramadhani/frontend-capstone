import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class DaftarPengrajinController extends GetxController {
  RxBool isLoading = false.obs;

  RxList pengrajin = [].obs;

  @override
  void onInit() {
    super.onInit();

    getPengrajin();
  }

  Future<void> getPengrajin() async {
    try {
      isLoading.value = true;

      final start = DateTime.now();

      final response = await PenggunaService.getPengrajin();

      print(DateTime.now().difference(start));

      print(response);

      if (response['success'] == true) {
        pengrajin.assignAll(
          List<Map<String, dynamic>>.from(response['pengrajin']),
        );
      } else {
        Get.snackbar("Error", response['message']);
      }
    } catch (e) {
      print(e);

      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
