import 'package:get/get.dart';

import '../../../../data/services/auth_service.dart';
import '../../../../data/services/pengrajin_service.dart';

class HalamanPengrajinController extends GetxController {
  RxBool isLoading = false.obs;

  RxString nama = "".obs;

  RxString photo = "".obs;

  RxInt totalPeserta = 0.obs;

  RxDouble rating = 0.0.obs;

  RxList<dynamic> jadwalHariIni = [].obs;

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;

      final response =
          await PengrajinService.getDashboard();

      print("=== DASHBOARD ===");
      print(response);

      if (response["success"] == true) {
        final pengrajin =
            response["pengrajin"] ?? {};

        nama.value =
            (pengrajin["name"] ?? "")
                .toString();

        photo.value =
            (pengrajin["photo"] ?? "")
                .toString();

        totalPeserta.value =
            int.tryParse(
                  response["totalPeserta"]
                          ?.toString() ??
                      "0",
                ) ??
                0;

        rating.value =
            double.tryParse(
                  response["rating"]
                          ?.toString() ??
                      "0",
                ) ??
                0.0;

        jadwalHariIni.assignAll(
          response["jadwalHariIni"] ?? [],
        );
      } else {
        Get.snackbar(
          "Error",
          response["message"] ??
              "Gagal mengambil data",
        );
      }
    } catch (e, s) {
      print("ERROR DASHBOARD");
      print(e);
      print(s);

      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await loadData();
  }

  void logout() async {
    await AuthService.logout();

    Get.offAllNamed("/");
  }
}