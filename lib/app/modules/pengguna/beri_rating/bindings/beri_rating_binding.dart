import 'package:get/get.dart';

import '../controllers/beri_rating_controller.dart';

class BeriRatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeriRatingController>(
      () => BeriRatingController(),
    );
  }
}
