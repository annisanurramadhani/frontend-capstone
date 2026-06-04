// edit_profil_view.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_profil_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class EditProfilView extends GetView<EditProfilController> {
  const EditProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // EDIT PROFIL
      bottomNavigationBar: const CustomNavbar(currentIndex: 2),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(size.width * 0.055),

            child: Column(
              children: [
                SizedBox(height: size.height * 0.01),

                // HEADER
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.kembali,

                      icon: const Icon(
                        Icons.arrow_back_ios_new,

                        color: Color(0xFF5A3116),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "Edit Profil",

                          style: TextStyle(
                            fontSize: size.width * 0.07,

                            fontWeight: FontWeight.bold,

                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),

                SizedBox(height: size.height * 0.04),

                // FOTO
                Stack(
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.16,

                      backgroundColor: const Color(0xFFF3EAE0),

                      child: Icon(
                        Icons.person,

                        size: size.width * 0.16,

                        color: const Color(0xFF5A3116),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,

                      child: Container(
                        width: 50,
                        height: 50,

                        decoration: const BoxDecoration(
                          color: Color(0xFF5A3116),

                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.camera_alt_outlined,

                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.05),

                // NAMA
                textField(
                  title: "Nama Lengkap",

                  controller: controller.namaController,

                  hint: "Masukkan nama lengkap",

                  icon: Icons.person_outline,
                ),

                SizedBox(height: size.height * 0.025),

                // EMAIL
                textField(
                  title: "Email",

                  controller: controller.emailController,

                  hint: "Masukkan email",

                  icon: Icons.email_outlined,
                ),

                SizedBox(height: size.height * 0.025),

                // PASSWORD
                passwordField(),

                SizedBox(height: size.height * 0.05),

                // BUTTON
                SizedBox(
                  width: double.infinity,

                  height: 60,

                  child: ElevatedButton(
                    onPressed: controller.simpanPerubahan,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A3116),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    child: Text(
                      "Simpan Perubahan",

                      style: TextStyle(
                        fontSize: size.width * 0.045,

                        fontWeight: FontWeight.bold,

                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget textField({
    required String title,

    required TextEditingController controller,

    required String hint,

    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: const TextStyle(
            fontSize: 18,

            fontWeight: FontWeight.bold,

            color: Color(0xFF3E2723),
          ),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: controller,

          decoration: InputDecoration(
            hintText: hint,

            prefixIcon: Icon(icon, color: const Color(0xFF5A3116)),

            filled: true,

            fillColor: Colors.white,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),

              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "Password Baru",

          style: TextStyle(
            fontSize: 18,

            fontWeight: FontWeight.bold,

            color: Color(0xFF3E2723),
          ),
        ),

        const SizedBox(height: 12),

        Obx(
          () => TextField(
            controller: controller.passwordController,

            obscureText: controller.isPasswordHidden.value,

            decoration: InputDecoration(
              hintText: "Masukkan password baru",

              prefixIcon: const Icon(
                Icons.lock_outline,

                color: Color(0xFF5A3116),
              ),

              suffixIcon: IconButton(
                onPressed: controller.togglePassword,

                icon: Icon(
                  controller.isPasswordHidden.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,

                  color: const Color(0xFF5A3116),
                ),
              ),

              filled: true,

              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),

                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          "Kosongkan jika tidak ingin mengubah password",

          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
