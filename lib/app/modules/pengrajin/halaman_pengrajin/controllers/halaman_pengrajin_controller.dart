import 'package:get/get.dart';
import '../../../../data/services/pengrajin_service.dart';

class HalamanPengrajinController extends GetxController {
  final PengrajinService _service = PengrajinService();

  final isLoading = false.obs;

  final totalPeserta = 0.obs;
  final rating = 0.0.obs;

  final jadwalHariIni = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;

      final result =
          await _service.getDashboardPengrajin();

      totalPeserta.value =
          result["totalPeserta"] ?? 0;

      rating.value =
          (result["rating"] ?? 0).toDouble();

      jadwalHariIni.assignAll(
        result["jadwalHariIni"] ?? [],
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}