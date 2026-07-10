import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/providers/api_provider.dart';
import '../controllers/edit_profil_controller.dart';

class EditProfilView extends GetView<EditProfilController> {
  const EditProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),

      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: Column(
              children: [
                const SizedBox(height: 20),

                SizedBox(
                  height: h * 0.065,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: controller.kembali,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: w * 0.055,
                            color: const Color(0xFF5A3116),
                          ),
                        ),
                      ),

                      Text(
                        "Edit Profil",
                        style: TextStyle(
                          fontSize: w * 0.065,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3E2723),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: h * 0.003),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "Perbarui informasi akun Anda.",
                    style: TextStyle(
                      fontSize: w * 0.034,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: h * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Obx(() {
                        if (controller.selectedImage.value != null) {
                          return CircleAvatar(
                            radius: w * 0.14,
                            backgroundImage: FileImage(
                              File(controller.selectedImage.value!.path),
                            ),
                          );
                        }

                        if (controller.photoUrl.value.isNotEmpty) {
                          return CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(
                              controller.photoUrl.value.startsWith("http")
                                  ? controller.photoUrl.value
                                  : "${ApiProvider.baseUrl}${controller.photoUrl.value}",
                            ),
                          );
                        }

                        return CircleAvatar(
                          radius: 55,
                          backgroundColor: Color(0xFFF3EAE0),
                          child: Icon(
                            Icons.person,
                            size: w * 0.15,
                            color: Color(0xFF5A3116),
                          ),
                        );
                      }),

                      const SizedBox(height: 18),

                      SizedBox(
                        height: h * 0.05,
                        child: OutlinedButton.icon(
                          onPressed: controller.pilihFoto,
                          icon: const Icon(
                            Icons.photo_camera_outlined,
                            size: 18,
                          ),
                          label: const Text("Ubah Foto"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF5A3116),
                            side: const BorderSide(color: Color(0xFF5A3116)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),
                textField(
                  title: "Nama Lengkap",
                  controller: controller.namaController,
                  hint: "Masukkan nama lengkap",
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 20),

                textField(
                  title: "Email",
                  controller: controller.emailController,
                  hint: "Masukkan email",
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 20),

                passwordField(),

                const SizedBox(height: 10),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Kosongkan password jika tidak ingin mengubah password.",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: h * 0.065,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.simpanPerubahan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A3116),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Simpan Perubahan",
                            style: TextStyle(
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "ATAU",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: h * 0.065,
                  child: OutlinedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            final konfirmasi = await Get.dialog<bool>(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                title: const Text("Hapus Akun"),
                                content: const Text(
                                  "Apakah Anda yakin ingin menghapus akun? Semua data akan dihapus secara permanen.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(result: false),
                                    child: const Text("Batal"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Get.back(result: true),
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
                    label: const Text(
                      "Hapus Akun",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
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
          style: const TextStyle(fontSize: 14, color: Color(0xFF3E2723)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),

            prefixIcon: Icon(icon, color: const Color(0xFF5A3116)),

            filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF5A3116)),
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
            style: const TextStyle(fontSize: 15, color: Color(0xFF3E2723)),
            decoration: InputDecoration(
              hintText: "Masukkan password baru",

              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),

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

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFF5A3116)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}