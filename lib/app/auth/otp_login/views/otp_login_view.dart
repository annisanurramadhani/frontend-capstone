// otp_login_view.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/otp_login_controller.dart';

class OtpLoginView extends GetView<OtpLoginController> {
  const OtpLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          // BACKGROUND
          Container(
            width: double.infinity,
            height: double.infinity,

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,

                colors: [Color(0xFFF5E6D3), Color(0xFFD7A97B)],
              ),
            ),
          ),

          // OVERLAY
          Container(color: Colors.white.withValues(alpha: 0.12)),

          SafeArea(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.only(bottom: 0),

              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        size.height - MediaQuery.of(context).viewInsets.bottom,
                  ),

                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.08,
                      vertical: 24,
                    ),

                    child: Column(
                      children: [
                        SizedBox(
                          height: keyboardOpen
                              ? size.height * 0.01
                              : size.height * 0.02,
                        ),

                        // HEADER
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },

                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Color(0xFF5A3116),
                              ),
                            ),

                            Expanded(
                              child: Column(
                                children: [
                                  // TITLE
                                  Text(
                                    "Masukkan Kode OTP",

                                    textAlign: TextAlign.center,

                                    style: TextStyle(
                                      fontSize: keyboardOpen
                                          ? size.width * 0.07
                                          : size.width * 0.085,

                                      fontWeight: FontWeight.bold,

                                      color: const Color(0xFF3E2723),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  Text(
                                    "Masukkan kode 6 digit yang telah dikirim ke email Anda.",

                                    textAlign: TextAlign.center,

                                    style: TextStyle(
                                      fontSize: size.width * 0.042,

                                      color: Colors.brown,

                                      height: 1.7,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 48),
                          ],
                        ),

                        SizedBox(
                          height: keyboardOpen
                              ? size.height * 0.03
                              : size.height * 0.06,
                        ),

                        // OTP CARD
                        Container(
                          width: double.infinity,

                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.93),

                            borderRadius: BorderRadius.circular(32),
                          ),

                          child: Column(
                            children: [
                              const SizedBox(height: 15),

                              // OTP FIELD
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  otpField(
                                    controller: controller.otp1Controller,

                                    currentFocus: controller.focus1,

                                    nextFocus: controller.focus2,
                                  ),

                                  otpField(
                                    controller: controller.otp2Controller,

                                    currentFocus: controller.focus2,

                                    nextFocus: controller.focus3,
                                  ),

                                  otpField(
                                    controller: controller.otp3Controller,

                                    currentFocus: controller.focus3,

                                    nextFocus: controller.focus4,
                                  ),

                                  otpField(
                                    controller: controller.otp4Controller,

                                    currentFocus: controller.focus4,

                                    nextFocus: controller.focus5,
                                  ),

                                  otpField(
                                    controller: controller.otp5Controller,

                                    currentFocus: controller.focus5,

                                    nextFocus: controller.focus6,
                                  ),

                                  otpField(
                                    controller: controller.otp6Controller,

                                    currentFocus: controller.focus6,
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: keyboardOpen
                                    ? size.height * 0.03
                                    : size.height * 0.05,
                              ),

                              // BUTTON
                              SizedBox(
                                width: double.infinity,

                                height: 58,

                                child: Obx(
                                  () => ElevatedButton(
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : controller.verifikasiOtp,

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF5A3116),

                                      elevation: 0,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),

                                    child: controller.isLoading.value
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            "Lanjutkan",

                                            style: TextStyle(
                                              fontSize: size.width * 0.05,

                                              fontWeight: FontWeight.bold,

                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),

                              SizedBox(height: size.height * 0.035),

                              // RESEND
                              Obx(() {
                                if (controller.isResending.value) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      const SizedBox(
                                        width: 16,
                                        height: 16,

                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,

                                          color: Color(0xFF8B5E3C),
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      Text(
                                        "Mengirim kode...",

                                        style: TextStyle(
                                          fontSize: size.width * 0.038,

                                          color: Colors.brown.shade400,
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                if (!controller.canResend.value) {
                                  return Column(
                                    children: [
                                      Text(
                                        "Tidak menerima kode?",

                                        style: TextStyle(
                                          fontSize: size.width * 0.038,

                                          color: Colors.brown.shade400,
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [
                                          const Icon(
                                            Icons.timer_outlined,

                                            size: 16,

                                            color: Color(0xFF8B5E3C),
                                          ),

                                          const SizedBox(width: 4),

                                          Text(
                                            "Kirim ulang dalam ${controller.countdown.value}s",

                                            style: TextStyle(
                                              fontSize: size.width * 0.038,

                                              color: Colors.brown.shade400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }

                                return Column(
                                  children: [
                                    Text(
                                      "Tidak menerima kode?",

                                      style: TextStyle(
                                        fontSize: size.width * 0.038,

                                        color: Colors.brown.shade400,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    GestureDetector(
                                      onTap: controller.kirimUlangOtp,

                                      child: Text(
                                        "Kirim ulang kode",

                                        style: TextStyle(
                                          fontSize: size.width * 0.04,

                                          fontWeight: FontWeight.bold,

                                          color: const Color(0xFF5A3116),

                                          decoration: TextDecoration.underline,

                                          decorationColor: const Color(
                                            0xFF5A3116,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget otpField({
    required TextEditingController controller,
    FocusNode? currentFocus,
    FocusNode? nextFocus,
  }) {
    return SizedBox(
      width: 38,
      height: 52,

      child: TextField(
        controller: controller,

        focusNode: currentFocus,

        autofocus: currentFocus == Get.find<OtpLoginController>().focus1,

        textAlign: TextAlign.center,

        keyboardType: TextInputType.number,

        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,

          LengthLimitingTextInputFormatter(1),
        ],

        onChanged: (value) {
          if (value.length == 1 && nextFocus != null) {
            FocusScope.of(Get.context!).requestFocus(nextFocus);
          }

          if (value.isEmpty && currentFocus != null) {
            currentFocus.previousFocus();
          }
        },

        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3E2723),
        ),

        decoration: InputDecoration(
          filled: true,

          fillColor: Colors.white,

          contentPadding: EdgeInsets.zero,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: BorderSide(color: Colors.brown.shade200, width: 1.5),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: const BorderSide(color: Color(0xFF8B5E3C), width: 2),
          ),
        ),
      ),
    );
  }
}
