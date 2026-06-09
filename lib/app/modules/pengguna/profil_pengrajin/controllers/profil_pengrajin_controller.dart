import 'package:get/get.dart';

class ProfilPengrajinController extends GetxController {
  RxMap<String, dynamic> pengrajin = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();

    pengrajin.value = Get.arguments;
  }
}
