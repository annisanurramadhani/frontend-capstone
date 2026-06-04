import 'package:get/get.dart';

import '../controllers/otp_lupa_password_controller.dart';

class OtpLupaPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpLupaPasswordController>(
      () => OtpLupaPasswordController(),
    );
  }
}
