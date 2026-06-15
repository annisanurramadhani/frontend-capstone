import 'package:get/get.dart';

class DetailVideoController extends GetxController {
  RxMap<String, dynamic> video = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();

    video.value = Get.arguments;
  }
}