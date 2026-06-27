// password_baru_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/password_baru_controller.dart';

class PasswordBaruView extends GetView<PasswordBaruController> {
  const PasswordBaruView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Stack(
        children: [
          // BACKGROUND
          Container(color: const Color(0xFFF7EFE6)),

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
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFF5A3116),
                            ),
                          ),

                          Expanded(
                            child: Center(
                              child: Text(
                                "Perbarui Sandi",
                                style: TextStyle(
                                  fontSize: size.width * 0.065,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3E2723),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 48),
                        ],
                      ),

                      SizedBox(height: size.height * 0.003),

                      Center(
                        child: SizedBox(
                          width: size.width * 0.82,
                          child: Text(
                            "Masukkan sandi baru untuk akun Anda",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.width * 0.034,
                              color: Colors.grey,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.045),
                      // CARD
                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.90),

                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            // PASSWORD BARU
                            buildTitle("Sandi Baru", size),

                            const SizedBox(height: 12),

                            Obx(
                              () => TextField(
                                controller: controller.passwordBaruController,

                                obscureText: controller.isPasswordHidden.value,

                                decoration: inputDecoration(
                                  hint: "Masukkan sandi baru",

                                  icon: Icons.lock_outline,

                                  suffix: IconButton(
                                    onPressed: controller.togglePassword,

                                    icon: Icon(
                                      controller.isPasswordHidden.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,

                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),

                            // KONFIRMASI PASSWORD
                            buildTitle("Konfirmasi Sandi", size),

                            const SizedBox(height: 12),

                            Obx(
                              () => TextField(
                                controller:
                                    controller.konfirmasiPasswordController,

                                obscureText:
                                    controller.isKonfirmasiPasswordHidden.value,

                                decoration: inputDecoration(
                                  hint: "Konfirmasi sandi baru",

                                  icon: Icons.lock_outline,

                                  suffix: IconButton(
                                    onPressed:
                                        controller.toggleKonfirmasiPassword,

                                    icon: Icon(
                                      controller
                                              .isKonfirmasiPasswordHidden
                                              .value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,

                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),
                            // BUTTON
                            SizedBox(
                              width: double.infinity,

                              height: 56,

                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.simpanPasswordBaru,

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF7B4B2A),

                                    elevation: 0,

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),

                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Simpan Sandi",

                                          style: TextStyle(
                                            fontSize: size.width * 0.045,

                                            fontWeight: FontWeight.bold,

                                            color: Colors.white,
                                          ),
                                        ),
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

  Widget buildTitle(String title, Size size) {
    return Text(
      title,

      style: TextStyle(
        fontSize: size.width * 0.038,

        fontWeight: FontWeight.w600,
      ),
    );
  }

  InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,

      prefixIcon: Icon(icon, color: Colors.brown),

      suffixIcon: suffix,

      filled: true,

      fillColor: const Color(0xFFF9F7F5),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.brown.shade100),
      ),

      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: Color(0xFF8B5E3C), width: 1.5),
      ),
    );
  }
}
