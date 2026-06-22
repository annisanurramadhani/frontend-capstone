import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profil_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';
import '../../../../data/providers/api_provider.dart';

class EditProfilView extends GetView<EditProfilController> {
  const EditProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      bottomNavigationBar: const CustomNavbar(currentIndex: 2),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                        size: 20,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Edit Profil",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
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
                    Obx(() {
                      if (controller.selectedImage.value != null) {
                        return CircleAvatar(
                          radius: size.width * 0.16,
                          backgroundImage: FileImage(
                            File(controller.selectedImage.value!.path),
                          ),
                        );
                      }

                      if (controller.photoUrl.value.isNotEmpty) {
                        return CircleAvatar(
                          radius: size.width * 0.16,
                          backgroundImage: NetworkImage(
                            "${ApiProvider.baseUrl}${controller.photoUrl.value}",
                          ),
                        );
                      }

                      return CircleAvatar(
                        radius: size.width * 0.16,
                        backgroundColor: const Color(0xFFF3EAE0),
                        child: Icon(
                          Icons.person,
                          size: size.width * 0.16,
                          color: const Color(0xFF5A3116),
                        ),
                      );
                    }),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: controller.pilihFoto,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFF5A3116),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.04),

                // NAMA
                textField(
                  title: "Nama Lengkap",
                  controller: controller.namaController,
                  hint: "Masukkan nama lengkap",
                  icon: Icons.person_outline,
                ),

                SizedBox(height: size.height * 0.02),

                // EMAIL
                textField(
                  title: "Email",
                  controller: controller.emailController,
                  hint: "Masukkan email",
                  icon: Icons.email_outlined,
                ),

                SizedBox(height: size.height * 0.02),

                // PASSWORD
                passwordField(),

                SizedBox(height: size.height * 0.04),

                // BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.simpanPerubahan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A3116),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Simpan Perubahan",

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 14),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            final konfirmasi = await Get.dialog<bool>(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Row(
                                  children: [
                                    Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 8),
                                    Text("Hapus Akun"),
                                  ],
                                ),
                                content: const Text(
                                  "Apakah Anda yakin ingin menghapus akun?\n\nSemua data akun akan dihapus permanen dan tidak dapat dikembalikan.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back(result: false);
                                    },
                                    child: const Text("Batal"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back(result: true);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text(
                                      "Hapus",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (konfirmasi == true) {
                              controller.hapusAkun();
                            }
                          },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    icon: const Icon(Icons.delete_forever),
                    label: const Text(
                      "Hapus Akun",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3E2723),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
            prefixIcon: Icon(icon, color: const Color(0xFF5A3116), size: 20),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
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
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3E2723),
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextField(
            controller: controller.passwordController,
            obscureText: controller.isPasswordHidden.value,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: "Masukkan password baru",
              hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF5A3116),
                size: 20,
              ),
              suffixIcon: IconButton(
                onPressed: controller.togglePassword,
                icon: Icon(
                  controller.isPasswordHidden.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: const Color(0xFF5A3116),
                  size: 20,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Kosongkan jika tidak ingin mengubah password",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }
}
