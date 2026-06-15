import 'package:get/get.dart';
import 'dart:async';
import '../../../../data/services/pengguna_service.dart';

class JadwalSayaController extends GetxController {
  RxBool isLoading = true.obs;

  RxList jadwal = [].obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    getJadwal();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      getJadwal(showLoading: false);
    });
  }

  Future<void> getJadwal({bool showLoading = true}) async {
    try {
      if (showLoading) {
        isLoading.value = true;
      }

      final response = await PenggunaService.getJadwalKelas();

      print(response);

      if (response["success"] == true) {
        jadwal.assignAll(response["jadwal"] ?? []);
      }
    } catch (e) {
      print(e);
    } finally {
      if (showLoading) {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
