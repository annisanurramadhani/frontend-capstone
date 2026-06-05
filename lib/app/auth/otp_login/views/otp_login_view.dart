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

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          Container(color: Colors.white.withValues(alpha: 0.15)),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: size.height),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.08,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02),

                      // BACK
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF5A3116),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // ICON
                      Container(
                        width: size.width * 0.24,
                        height: size.width * 0.24,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.90),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.mark_email_read_outlined,
                          size: size.width * 0.12,
                          color: const Color(0xFF8B5E3C),
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // TITLE
                      Text(
                        "Verifikasi OTP",
                        style: TextStyle(
                          fontSize: size.width * 0.085,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3E2723),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Masukkan kode OTP 6 digit yang telah dikirim ke email Anda.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.042,
                          color: Colors.brown,
                          height: 1.7,
                        ),
                      ),

                      SizedBox(height: size.height * 0.06),

                      // OTP CARD
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(size.width * 0.07),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            // OTP FIELDS
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                otpField(controller: controller.otp1Controller),
                                otpField(controller: controller.otp2Controller),
                                otpField(controller: controller.otp3Controller),
                                otpField(controller: controller.otp4Controller),
                                otpField(controller: controller.otp5Controller),
                                otpField(controller: controller.otp6Controller),
                              ],
                            ),

                            SizedBox(height: size.height * 0.05),

                            // TOMBOL VERIFIKASI
                            SizedBox(
                              width: double.infinity,
                              height: 58,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.verifikasiOtp,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8B5E3C),
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
                                          "Verifikasi",
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

                            // RESEND SECTION
                            Obx(() {
                              // Sedang mengirim ulang
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
                                      "Mengirim OTP...",
                                      style: TextStyle(
                                        fontSize: size.width * 0.038,
                                        color: Colors.brown.shade400,
                                      ),
                                    ),
                                  ],
                                );
                              }

                              // Masih countdown
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

                              // Boleh kirim ulang
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
                                      "Kirim ulang kode OTP",
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
        ],
      ),
    );
  }

  Widget otpField({required TextEditingController controller}) {
    return SizedBox(
      width: 48,
      height: 58,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
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
