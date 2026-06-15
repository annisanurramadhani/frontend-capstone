import 'package:get/get.dart';

class KelasSayaController extends GetxController {
  final isLoading = false.obs;

  final selectedTab = 0.obs;

  final kelasList = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    getKelasSaya();
  }

  Future<void> getKelasSaya() async {
    try {
      isLoading.value = true;

      // API disini nanti

    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }
}