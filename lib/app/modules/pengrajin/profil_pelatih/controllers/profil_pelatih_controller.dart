import 'package:get/get.dart';

import '../../../../data/services/auth_service.dart';
import '../../../../data/services/pengrajin_service.dart';
import '../../../../routes/app_pages.dart';

class ProfilPelatihController extends GetxController {
  RxBool isLoading = false.obs;

  RxString foto = "".obs;

  RxString nama = "".obs;

  RxString email = "".obs;

  RxString noHp = "".obs;

  RxString alamat = "".obs;

  RxString pengalaman = "".obs;

  RxString deskripsi = "".obs;

  @override
  void onInit() {
    super.onInit();

    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;

      final response = await PengrajinService.getProfile();

      if (response["success"] == true) {
        final data = response["data"];

        final profile = data["pengrajinProfile"];

        nama.value = data["name"] ?? "";

        email.value = data["email"] ?? "";

        foto.value = data["photo"] ?? "";

        noHp.value = profile?["noTelpon"] ?? "";

        alamat.value = profile?["alamat"] ?? "";

        pengalaman.value = profile?["pengalaman"] ?? "";

        deskripsi.value = profile?["deskripsi"] ?? "";
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editProfil() async {
    final result = await Get.toNamed(Routes.EDIT_PROFIL_PELATIH);

    if (result == true) {
      await loadProfile();
      update();
    }
  }

  Future<void> logout() async {
    await AuthService.logout();

    Get.offAllNamed(Routes.MASUK);
  }
}
