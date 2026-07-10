import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../global_widgets/custom_navbar.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),

      bottomNavigationBar: const CustomNavbar(currentIndex: 4),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF5A3116)),
            );
          }

          return SingleChildScrollView(
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
                        "Profil Saya",
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "Kelola informasi akun Anda dan pengaturan aplikasi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 28,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
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
                      CircleAvatar(
                        radius: 52,
                        backgroundColor: const Color(0xFFF3EAE0),
                        backgroundImage:
                            controller.user["photo"] != null &&
                                    controller.user["photo"].toString().isNotEmpty
                                ? NetworkImage(
                                    controller.user["photo"].toString().startsWith("http")
                                        ? controller.user["photo"]
                                        : "${ApiProvider.baseUrl}${controller.user["photo"]}",
                                  )
                                : null,
                        child:
                            controller.user["photo"] == null ||
                                    controller.user["photo"].toString().isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 56,
                                    color: Color(0xFF5A3116),
                                  )
                                : null,
                      ),

                      const SizedBox(height: 18),

                      Text(
                        controller.user["name"] ?? "-",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        controller.user["email"] ?? "-",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                menuItem(
                  icon: Icons.person_outline,
                  title: "Edit Profil",
                  subtitle: "Ubah informasi akun",
                  onTap: controller.keEditProfil,
                ),

                const SizedBox(height: 16),

                menuItem(
                  icon: Icons.history_rounded,
                  title: "Riwayat Aktivitas",
                  subtitle: "Lihat aktivitas Anda",
                  onTap: controller.keRiwayatAktivitas,
                ),

                const SizedBox(height: 16),

                menuItem(
                  icon: Icons.logout_rounded,
                  title: "Keluar",
                  subtitle: "Keluar dari akun",
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: controller.keluar,
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF5A3116),
    Color textColor = const Color(0xFF3E2723),
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: Color(0xFFF3EAE0),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Icon(Icons.chevron_right_rounded, color: iconColor, size: 28),
          ],
        ),
      ),
    );
  }
}