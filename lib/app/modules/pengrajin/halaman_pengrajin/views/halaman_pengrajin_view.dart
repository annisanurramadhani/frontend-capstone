import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/halaman_pengrajin_controller.dart';
import '../../../../global_widgets/navbar_pengrajin.dart';
import '../../../../data/providers/api_provider.dart';
import '../../../../routes/app_pages.dart';

class HalamanPengrajinView extends GetView<HalamanPengrajinController> {
  const HalamanPengrajinView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF5A3116)),
            );
          }

          return RefreshIndicator(
            color: const Color(0xFF5A3116),
            onRefresh: controller.loadData,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: 20,
              ),
              children: [
                // HEADER
                Row(
                  children: [
                    // FOTO
                    ClipOval(
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFD7A97B),
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: controller.photo.value.isNotEmpty
                            ? Image.network(
                                "${ApiProvider.baseUrl}/uploads/${controller.photo.value}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 35,
                                    color: Color(0xFF5A3116),
                                  );
                                },
                              )
                            : const Icon(
                                Icons.person,
                                size: 35,
                                color: Color(0xFF5A3116),
                              ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Selamat Datang!",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF8B6347),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            controller.nama.value.isEmpty
                                ? "Pengrajin"
                                : controller.nama.value,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3E2723),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // NOTIFIKASI
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.NOTIFIKASI_PENGRAJIN),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3EAE0),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: Color(0xFF5A3116),
                              size: 24,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.03),

                // STAT CARDS
                Row(
                  children: [
                    Expanded(
                      child: _statCard(
                        title: "Total Peserta",
                        value: controller.totalPeserta.value.toString(),
                        icon: Icons.groups_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard(
                        title: "Rating",
                        value: controller.rating.value.toString(),
                        icon: Icons.star_outline_rounded,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.03),

                // JADWAL HARI INI
                const Text(
                  "Jadwal Hari Ini",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),

                const SizedBox(height: 12),

                if (controller.jadwalHariIni.isEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 40,
                          color: Color(0xFFD7C4B0),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Belum ada jadwal hari ini",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8B6347),
                          ),
                        ),
                      ],
                    ),
                  ),

                ...controller.jadwalHariIni.map(
                  (jadwal) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF3EAE0),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: Color(0xFF5A3116),
                            size: 22,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                jadwal["namaLengkap"] ?? "-",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3E2723),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 12,
                                    color: Color(0xFF8B6347),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    jadwal["tanggal"] ?? "-",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF8B6347),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.access_time_outlined,
                                    size: 12,
                                    color: Color(0xFF8B6347),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    jadwal["jamPelatihan"] ?? "-",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF8B6347),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: (jadwal["statusKelas"] ?? "") == "selesai"
                                ? const Color(0xFFDCF5E7)
                                : const Color(0xFFFFF3CD),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            jadwal["statusKelas"] ?? "-",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: (jadwal["statusKelas"] ?? "") == "selesai"
                                  ? const Color(0xFF1A7A4A)
                                  : const Color(0xFF856404),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.02),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: const NavbarPengrajin(currentIndex: 1),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFF3EAE0),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF5A3116), size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E2723),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Color(0xFF8B6347)),
          ),
        ],
      ),
    );
  }
}