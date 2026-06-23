import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profil_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';
import '../../../../data/providers/api_provider.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      bottomNavigationBar: const CustomNavbar(currentIndex: 2),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.055),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.01),

                  // CARD PROFIL
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: size.width * 0.14,
                          backgroundColor: const Color(0xFFF3EAE0),
                          backgroundImage:
                              controller.user["photo"] != null &&
                                  controller.user["photo"].toString().isNotEmpty
                              ? NetworkImage(
                                  "${ApiProvider.baseUrl}${controller.user["photo"]}",
                                )
                              : null,
                          child:
                              controller.user["photo"] == null ||
                                  controller.user["photo"].toString().isEmpty
                              ? Icon(
                                  Icons.person,
                                  size: size.width * 0.14,
                                  color: const Color(0xFF5A3116),
                                )
                              : null,
                        ),

                        SizedBox(height: size.height * 0.025),

                        Text(
                          controller.user["name"] ?? "-",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),

                        SizedBox(height: size.height * 0.01),

                        Text(
                          controller.user["email"] ?? "-",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  // EDIT PROFIL
                  menuItem(
                    size: size,
                    icon: Icons.person_outline,
                    title: "Edit Profil",
                    subtitle: "Ubah informasi akun",
                    onTap: controller.keEditProfil,
                  ),

                  SizedBox(height: size.height * 0.02),

                  // SERTIFIKAT
                  menuItem(
                    size: size,
                    icon: Icons.workspace_premium_outlined,
                    title: "Sertifikat Saya",
                    subtitle: "Lihat sertifikat kelas",
                    onTap: controller.keSertifikat,
                  ),

                  SizedBox(height: size.height * 0.02),

                  // RIWAYAT AKTIVITAS
                  menuItem(
                    size: size,
                    icon: Icons.history_rounded,
                    title: "Riwayat Aktivitas",
                    subtitle: "Lihat Riwayat Aktivitas",
                    onTap: controller.keRiwayatAktivitas,
                  ),

                  SizedBox(height: size.height * 0.02),

                  // KELUAR
                  menuItem(
                    size: size,
                    icon: Icons.logout_rounded,
                    title: "Keluar",
                    subtitle: "Keluar dari akun",
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: controller.keluar,
                  ),

                  SizedBox(height: size.height * 0.05),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget menuItem({
    required Size size,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF5A3116),
    Color textColor = const Color(0xFF3E2723),
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          children: [
            Container(
              width: size.width * 0.14,
              height: size.width * 0.14,
              decoration: const BoxDecoration(
                color: Color(0xFFF3EAE0),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: size.width * 0.08),
            ),

            SizedBox(width: size.width * 0.04),

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
                    style: const TextStyle(fontSize: 13, color: Colors.brown),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: iconColor,
              size: size.width * 0.06,
            ),
          ],
        ),
      ),
    );
  }
}