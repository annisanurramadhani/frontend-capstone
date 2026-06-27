// masuk_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/masuk_controller.dart';

class MasukView extends GetView<MasukController> {
  const MasukView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

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

                child: Padding(
                  padding: EdgeInsets.zero,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(height: size.height * 0.01),

                      // HEADER
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
                                  onPressed: controller.kembali,
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
                                "Masuk",
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
                            width: w * 0.80,
                            child: Text(
                              "Masukkan email dan kata sandi untuk melanjutkan ke akun Anda.",
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

                      // FORM
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
                            buildTitle("Email", size),

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

                            buildTitle("Kata Sandi", size),

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

                            const SizedBox(height: 14),
                            // LUPA PASSWORD
                            Align(
                              alignment: Alignment.centerRight,

                              child: GestureDetector(
                                onTap: controller.lupaPassword,

                                child: const Text(
                                  "Lupa kata sandi?",

                                  style: TextStyle(
                                    color: Color(0xFF5A3116),

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: size.height * 0.04),

                            // BUTTON MASUK
                            SizedBox(
                              width: double.infinity,
                              height: h * 0.065,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.masuk,
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
                                          "Masuk",
                                          style: TextStyle(
                                            fontSize: w * 0.042,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            // DIVIDER
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(color: Colors.brown.shade200),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),

                                  child: Text(
                                    "atau",

                                    style: TextStyle(
                                      fontSize: size.width * 0.038,

                                      color: Colors.brown,
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Divider(color: Colors.brown.shade200),
                                ),
                              ],
                            ),

                            // GOOGLE
                            SizedBox(
                              width: double.infinity,

                              height: h * 0.067,
                              child: OutlinedButton(
                                onPressed: controller.masukDenganGoogle,

                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,

                                  side: BorderSide(
                                    color: Colors.brown.shade200,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      w * 0.05,
                                    ),
                                  ),
                                ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Image.asset(
                                      "assets/image/google.png",

                                      width: w * 0.06,
                                    ),

                                    const SizedBox(width: 14),

                                    Text(
                                      "Masuk dengan Google",
                                      style: TextStyle(
                                        fontSize: w * 0.042,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF3E2723),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            // DAFTAR
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Belum punya akun? ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.brown,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: controller.goToDaftar,
                                  child: const Text(
                                    "Daftar",
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
          ),
        ],
      ),
    );
  }

  Widget buildTitle(String title, Size size) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size.width * 0.032,
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
