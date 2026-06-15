import 'package:get/get.dart';

class ProfilPelatihController extends GetxController {

  final isLoading = false.obs;

  final nama = ''.obs;
  final email = ''.obs;
  final noHp = ''.obs;
  final alamat = ''.obs;
  final foto = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProfil();
  }

  Future<void> getProfil() async {
    try {
      isLoading.value = true;

      // TODO:
      // panggil API profil pelatih

      /*
      final result =
          await PelatihService.getProfil();

      nama.value = result["nama"] ?? "";
      email.value = result["email"] ?? "";
      noHp.value = result["noHp"] ?? "";
      alamat.value = result["alamat"] ?? "";
      foto.value = result["foto"] ?? "";
      */

    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void editProfil() {
    // Get.toNamed(Routes.EDIT_PROFIL_PELATIH);
  }

  void logout() {
    // hapus token
    // Get.offAllNamed(Routes.MASUK);
  }
}