// masuk_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/masuk_controller.dart';

class MasukView extends GetView<MasukController> {
  const MasukView({super.key});

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
                  padding: EdgeInsets.zero,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(height: size.height * 0.01),

                      // HEADER
                      Row(
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

                          const Spacer(),

                          // LOGO
                          SizedBox(
                            width: 130,
                            height: 130,
                            child: Image.asset(
                              "assets/image/logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          const Spacer(),

                          const SizedBox(width: 48),
                        ],
                      ),

                      SizedBox(height: size.height * 0.01),

                      // FORM
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: size.height),

                        margin: EdgeInsets.only(top: size.height * 0.01),

                        padding: const EdgeInsets.fromLTRB(24, 35, 24, 24),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
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
                            Center(
                              child: Text(
                                "Masuk",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3E2723),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
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

                              height: 58,

                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.masuk,

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5A3116),

                                    elevation: 0,

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),

                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Masuk",

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

                            // DIVIDER
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(color: Colors.brown.shade200),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
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

                              height: 58,

                              child: OutlinedButton(
                                onPressed: controller.masukDenganGoogle,

                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,

                                  side: BorderSide(
                                    color: Colors.brown.shade200,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Image.asset(
                                      "assets/image/google.png",

                                      width: 24,
                                    ),

                                    const SizedBox(width: 14),

                                    Text(
                                      "Masuk dengan Google",

                                      style: TextStyle(
                                        fontSize: size.width * 0.042,

                                        fontWeight: FontWeight.bold,

                                        color: const Color(0xFF3E2723),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: size.height * 0.04),

                            // DAFTAR
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(
                                  "Belum punya akun? ",

                                  style: TextStyle(
                                    fontSize: size.width * 0.038,

                                    color: Colors.brown,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: controller.goToDaftar,

                                  child: Text(
                                    "Daftar",

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

                      SizedBox(height: size.height * 0.05),
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
