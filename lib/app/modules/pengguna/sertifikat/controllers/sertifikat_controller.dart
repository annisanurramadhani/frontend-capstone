import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../data/services/pengguna_service.dart';

class SertifikatController extends GetxController {
  RxBool isLoading = true.obs;

  RxList sertifikatList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getSertifikat();
  }

  Future<void> getSertifikat() async {
    try {
      isLoading.value = true;

      final response =
          await PenggunaService.getSertifikat();

      print("=== RESPONSE SERTIFIKAT ===");
      print(response);

      if (response["success"] == true) {
        sertifikatList.assignAll(
          response["sertifikat"] ?? [],
        );
      }
    } catch (e) {
      print("ERROR SERTIFIKAT:");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void kembali() {
    Get.back();
  }

  Future<void> lihatSertifikat(
    dynamic data,
  ) async {
    if (data["sertifikatUrl"] == null) {
      return;
    }

    final url =
        "${ApiProvider.baseUrl}${data["sertifikatUrl"]}";

    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> unduhPdf(
    dynamic data,
  ) async {
    if (data["sertifikatUrl"] == null) {
      return;
    }

    final url =
        "${ApiProvider.baseUrl}${data["sertifikatUrl"]}";

    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}