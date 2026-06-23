import 'package:get/get.dart';
import '../../../../data/services/pengrajin_service.dart';

class NotifikasiPengrajinController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<dynamic> notifikasi = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;

      final response = await PengrajinService.getNotifikasi();

      if (response["success"] == true) {
        notifikasi.assignAll(response["data"] ?? []);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
