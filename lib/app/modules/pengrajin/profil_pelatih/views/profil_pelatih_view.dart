import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profil_pelatih_controller.dart';
import '../../../../global_widgets/navbar_pengrajin.dart';
import '../../../../data/providers/api_provider.dart';

class ProfilPelatihView extends GetView<ProfilPelatihController> {
  const ProfilPelatihView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profil",
          style: TextStyle(
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: const NavbarPengrajin(currentIndex: 2),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF5A3116)),
          );
        }

        final photo = controller.foto.value;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 32),
          child: Column(
            children: [
              // ── HERO CARD ─────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF5A3116),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    // foto
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5E3C),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFFFFE0B2),
                          width: 2,
                        ),
                        image: photo.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(
                                  photo.startsWith("http")
                                      ? photo
                                      : "${ApiProvider.baseUrl}${photo}",
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: photo.isEmpty
                          ? const Icon(
                              Icons.person_rounded,
                              size: 50,
                              color: Color(0xFFFFE0B2),
                            )
                          : null,
                    ),

                    const SizedBox(height: 14),

                    // nama
                    Obx(
                      () => Text(
                        controller.nama.value.isEmpty
                            ? "-"
                            : controller.nama.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5E3C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Pengrajin Anyaman",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFFE0B2),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── INFO ──────────────────────────────────────────────
              Obx(
                () => Column(
                  children: [
                    _InfoItem(
                      icon: Icons.email_outlined,
                      title: "Email",
                      value: controller.email.value.isEmpty
                          ? "-"
                          : controller.email.value,
                    ),
                    _InfoItem(
                      icon: Icons.phone_outlined,
                      title: "Nomor HP",
                      value: controller.noHp.value.isEmpty
                          ? "-"
                          : controller.noHp.value,
                    ),
                    _InfoItem(
                      icon: Icons.location_on_outlined,
                      title: "Alamat",
                      value: controller.alamat.value.isEmpty
                          ? "-"
                          : controller.alamat.value,
                    ),
                    _InfoItem(
                      icon: Icons.workspace_premium_outlined,
                      title: "Pengalaman",
                      value: controller.pengalaman.value.isEmpty
                          ? "-"
                          : controller.pengalaman.value,
                    ),
                    _InfoItem(
                      icon: Icons.description_outlined,
                      title: "Deskripsi",
                      value: controller.deskripsi.value.isEmpty
                          ? "-"
                          : controller.deskripsi.value,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── TOMBOL EDIT ────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: controller.editProfil,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A3116),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text(
                    "Edit Profil",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ── TOMBOL LOGOUT ──────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final result = await Get.dialog<bool>(
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text("Logout"),
                        content: const Text("Apakah Anda yakin ingin logout?"),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(result: false),
                            child: const Text("Batal"),
                          ),
                          ElevatedButton(
                            onPressed: () => Get.back(result: true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD32F2F),
                            ),
                            child: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (result == true) {
                      controller.logout();
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD32F2F),
                    side: const BorderSide(
                      color: Color(0xFFD32F2F),
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded, size: 18),
                  label: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ── INFO ITEM ─────────────────────────────────────────────────────────────────

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0E6DD), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF3EAE0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF5A3116)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8B6347),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
