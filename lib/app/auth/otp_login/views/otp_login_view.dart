import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/otp_login_controller.dart';

class OtpLoginView extends GetView<OtpLoginController> {
  const OtpLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF8EBDD), Color(0xFFF7EFE6)],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                    child: SizedBox(
                      height: h * 0.055,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () => Get.back(),
                              padding: EdgeInsets.zero,
                              splashRadius: 22,
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: const Color(0xFF5A3116),
                                size: w * 0.055,
                              ),
                            ),
                          ),

                          Text(
                            "OTP Login",
                            style: TextStyle(
                              fontSize: w * 0.065,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3E2723),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: w * .80,
                      child: Text(
                        "Masukkan 6 digit kode OTP yang telah dikirim ke email Anda.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: w * 0.035,
                          color: Colors.brown.shade600,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(w * 0.06),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.07),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.06),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Masukan Kode OTP",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3E2723),
                            ),
                          ),

                          const SizedBox(height: 14),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final boxWidth = (constraints.maxWidth - 40) / 6;

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  otpField(
                                    context: context,
                                    controller: controller.otp1Controller,
                                    width: boxWidth,
                                    isFirst: true,
                                  ),
                                  otpField(
                                    context: context,
                                    controller: controller.otp2Controller,
                                    width: boxWidth,
                                  ),
                                  otpField(
                                    context: context,
                                    controller: controller.otp3Controller,
                                    width: boxWidth,
                                  ),
                                  otpField(
                                    context: context,
                                    controller: controller.otp4Controller,
                                    width: boxWidth,
                                  ),
                                  otpField(
                                    context: context,
                                    controller: controller.otp5Controller,
                                    width: boxWidth,
                                  ),
                                  otpField(
                                    context: context,
                                    controller: controller.otp6Controller,
                                    width: boxWidth,
                                    isLast: true,
                                  ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 18),

                          SizedBox(
                            width: double.infinity,
                            height: h * 0.065,
                            child: Obx(
                              () => ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.verifikasiOtp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5A3116),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      w * 0.04,
                                    ),
                                  ),
                                ),
                                child: controller.isLoading.value
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "Verifikasi",
                                        style: TextStyle(
                                          fontSize: w * 0.042,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Obx(() {
                            if (controller.isResending.value) {
                              return const Center(
                                child: SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF5A3116),
                                  ),
                                ),
                              );
                            }

                            if (!controller.canResend.value) {
                              return Center(
                                child: Text(
                                  "Kirim ulang dalam ${controller.countdown.value} detik",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.brown,
                                  ),
                                ),
                              );
                            }

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Tidak menerima kode? ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.brown,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: controller.kirimUlangOtp,
                                  child: const Text(
                                    "Kirim Ulang",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5A3116),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget otpField({
    required BuildContext context,
    required TextEditingController controller,
    required double width,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return SizedBox(
      width: width,
      height: width * 1.2,
      child: TextField(
        controller: controller,
        autofocus: isFirst,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        style: TextStyle(
          fontSize: width * 0.45,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3E2723),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (!isLast) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          } else {
            if (!isFirst) {
              FocusScope.of(context).previousFocus();
            }
          }
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: const Color(0xFFF9F7F5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.brown.shade100),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFF8B5E3C), width: 1.5),
          ),
        ),
      ),
    );
  }
}
