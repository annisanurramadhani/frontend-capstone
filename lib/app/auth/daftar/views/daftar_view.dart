import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/daftar_controller.dart';

class DaftarView extends GetView<DaftarController> {
  const DaftarView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF8EBDD), Color(0xFFF7EFE6)],
                ),
              ),
            ),

            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: size.height),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                        child: SizedBox(
                          height: h * 0.055,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
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
                                "Daftar",
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
                        padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                        child: Center(
                          child: SizedBox(
                            width: size.width * 0.80,
                            child: Text(
                              "Buat akun baru untuk mulai belajar anyaman.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: w * 0.035,
                                color: Colors.brown.shade600,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: size.height),
                        margin: const EdgeInsets.only(top: 8),
                        padding: EdgeInsets.fromLTRB(
                          w * 0.06,
                          h * 0.02,
                          w * 0.06,
                          h * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(w * 0.08),
                            topRight: Radius.circular(w * 0.08),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, -3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTitle("Nama Lengkap"),

                            const SizedBox(height: 8),

                            TextField(
                              controller: controller.namaController,
                              decoration: inputDecoration(
                                hint: "Masukkan nama lengkap",
                                icon: Icons.person_outline,
                              ),
                            ),

                            const SizedBox(height: 20),

                            buildTitle("Email"),

                            const SizedBox(height: 8),

                            TextField(
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: inputDecoration(
                                hint: "Masukkan email",
                                icon: Icons.email_outlined,
                              ),
                            ),

                            const SizedBox(height: 20),
                            buildTitle("Kata Sandi"),

                            const SizedBox(height: 8),

                            Obx(
                              () => TextField(
                                controller: controller.passwordController,
                                obscureText: controller.isPasswordHidden.value,
                                decoration: inputDecoration(
                                  hint: "Masukkan kata sandi",
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

                            const SizedBox(height: 20),

                            buildTitle("Konfirmasi Kata Sandi"),

                            const SizedBox(height: 8),

                            Obx(
                              () => TextField(
                                controller:
                                    controller.konfirmasiPasswordController,
                                obscureText:
                                    controller.isKonfirmasiPasswordHidden.value,
                                decoration: inputDecoration(
                                  hint: "Konfirmasi kata sandi",
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

                            SizedBox(
                              width: double.infinity,
                              height: h * 0.065,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.daftar,
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
                                          "Daftar",
                                          style: TextStyle(
                                            fontSize: w * 0.042,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sudah punya akun? ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.brown,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: controller.goToLogin,
                                  child: const Text(
                                    "Masuk",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5A3116),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF3E2723),
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
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
      prefixIcon: Icon(icon, color: const Color(0xFF8B5E3C), size: 22),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFFF9F7F5),
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.brown.shade100),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: Color(0xFF8B5E3C), width: 1.5),
      ),
    );
  }
}
