import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/otp_lupa_password_controller.dart';

class OtpLupaPasswordView extends GetView<OtpLupaPasswordController> {
  const OtpLupaPasswordView({super.key});

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
                        "Masukkan kode OTP yang telah dikirim ke email Anda.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.042,
                          color: Colors.brown,
                          height: 1.7,
                        ),
                      ),

                      SizedBox(height: size.height * 0.06),

                      // CARD
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                otpField(controller: controller.otp1Controller, context: context),
                                SizedBox(width: size.width * 0.02),
                                otpField(controller: controller.otp2Controller, context: context),
                                SizedBox(width: size.width * 0.02),
                                otpField(controller: controller.otp3Controller, context: context),
                                SizedBox(width: size.width * 0.02),
                                otpField(controller: controller.otp4Controller, context: context),
                                SizedBox(width: size.width * 0.02),
                                otpField(controller: controller.otp5Controller, context: context),
                                SizedBox(width: size.width * 0.02),
                                otpField(controller: controller.otp6Controller, context: context),
                              ],
                            ),

                            SizedBox(height: size.height * 0.05),

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

                            // RESEND
                            GestureDetector(
                              onTap: controller.kirimUlangOtp,
                              child: Text(
                                "Kirim ulang kode OTP",
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF5A3116),
                                  decoration: TextDecoration.underline,
                                  decorationColor: const Color(0xFF5A3116),
                                ),
                              ),
                            ),
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

  Widget otpField({
    required TextEditingController controller,
    required BuildContext context,
  }) {
    final size = MediaQuery.of(context).size;
    final fieldSize = (size.width * 0.84 - (size.width * 0.07 * 2) - 5 * size.width * 0.02) / 6;

    return SizedBox(
      width: fieldSize,
      height: fieldSize * 1.2,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: TextStyle(
          fontSize: size.width * 0.055,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF3E2723),
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