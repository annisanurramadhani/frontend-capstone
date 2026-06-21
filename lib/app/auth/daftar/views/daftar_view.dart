// daftar_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/daftar_controller.dart';

class DaftarView extends GetView<DaftarController> {
  const DaftarView({super.key});

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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,

                colors: [Color(0xFFF8EBDD), Color(0xFFE8D2BC)],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: size.height + 200),

                child: Padding(
                  padding: const EdgeInsets.only(top: 24),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(height: size.height * 0.01),

                      // HEADER
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Color(0xFF5A3116),
                              ),
                            ),
                          ),

                          const Text(
                            "Daftar",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2723),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // FORM
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: size.height),

                        padding: EdgeInsets.all(size.width * 0.06),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),

                              blurRadius: 20,

                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.03),

                            // NAMA
                            buildTitle("Nama Lengkap", size),

                            TextField(
                              controller: controller.namaController,

                              decoration: inputDecoration(
                                hint: "Masukkan nama lengkap",

                                icon: Icons.person_outline,
                              ),
                            ),

                            const SizedBox(height: 25),

                            // EMAIL
                            buildTitle("Email", size),

                            const SizedBox(height: 12),

                            TextField(
                              controller: controller.emailController,

                              keyboardType: TextInputType.emailAddress,

                              decoration: inputDecoration(
                                hint: "Masukkan email",

                                icon: Icons.email_outlined,
                              ),
                            ),

                            const SizedBox(height: 25),

                            // PASSWORD
                            buildTitle("Kata Sandi", size),

                            const SizedBox(height: 12),

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

                            const SizedBox(height: 25),

                            // KONFIRMASI PASSWORD
                            buildTitle("Konfirmasi Kata Sandi", size),

                            const SizedBox(height: 12),

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

                            SizedBox(height: size.height * 0.05),

                            // BUTTON DAFTAR
                            SizedBox(
                              width: double.infinity,

                              height: 58,

                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.daftar,

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8B5E3C),

                                    elevation: 0,

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),

                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Daftar",

                                          style: TextStyle(
                                            fontSize: size.width * 0.05,

                                            fontWeight: FontWeight.bold,

                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),

                            SizedBox(height: size.height * 0.04),

                            // LOGIN
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(
                                  "Sudah punya akun? ",

                                  style: TextStyle(
                                    fontSize: size.width * 0.038,

                                    color: Colors.brown,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: controller.goToLogin,

                                  child: Text(
                                    "Masuk",

                                    style: TextStyle(
                                      fontSize: size.width * 0.038,

                                      fontWeight: FontWeight.bold,

                                      color: const Color(0xFF5A3116),
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
          ),
        ],
      ),
    );
  }

  Widget buildTitle(String title, Size size) {
    return Text(
      title,

      style: TextStyle(
        fontSize: size.width * 0.043,

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

      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(vertical: 18),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide.none,
      ),
    );
  }
}
