import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  const LupaPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF7EFE6),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.07,
                  vertical: 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 20,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.01),
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
                                      size: w * 0.055,
                                      color: const Color(0xFF5A3116),
                                    ),
                                  ),
                                ),

                                Text(
                                  "Lupa Kata Sandi",
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

                        Center(
                          child: SizedBox(
                            width: w * 0.80,
                            child: Text(
                              "Masukkan email yang terdaftar untuk menerima kode OTP.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: w * 0.035,
                                color: Colors.brown.shade600,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: h * 0.045),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(w * 0.06),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(w * 0.06),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: w * 0.036,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3E2723),
                                ),
                              ),

                              const SizedBox(height: 12),

                              TextField(
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Masukkan email",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Color(0xFF8B5E3C),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF9F7F5),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: Colors.brown.shade100,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFF8B5E3C),
                                      width: 1.5,
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
                                        : controller.kirimOtp,
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
                                            "Kirim OTP",
                                            style: TextStyle(
                                              fontSize: w * 0.042,
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

                        const Spacer(),

                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Center(
                            child: TextButton(
                              onPressed: controller.kembali,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.05,
                                  vertical: h * 0.015,
                                ),
                              ),
                              child: Text(
                                "Kembali ke Masuk",
                                style: TextStyle(
                                  color: Color(0xFF5A3116),
                                  fontSize: w * 0.038,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
