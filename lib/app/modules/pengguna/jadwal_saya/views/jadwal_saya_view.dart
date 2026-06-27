import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_navbar.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/jadwal_saya_controller.dart';

class JadwalSayaView extends GetView<JadwalSayaController> {
  const JadwalSayaView({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case "terjadwal":
        return Colors.blue;
      case "selesai":
        return Colors.green;
      case "dibatalkan":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF6F1),

        bottomNavigationBar: const CustomNavbar(currentIndex: 1),

        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: h * 0.02),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: SizedBox(
                  height: h * 0.065,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => Get.back(),
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
                        "Jadwal Saya",
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

              SizedBox(height: h * 0.001),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.09),
                child: Text(
                  "Kelola jadwal pelatihan yang sedang berlangsung.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: w * 0.034,
                    height: 1.4,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              TabBar(
                dividerColor: Colors.transparent,
                indicatorColor: Color(0xFF5A3116),
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Color(0xFF5A3116),
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(
                  fontSize: w * 0.039,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(text: "Jadwal"),
                  Tab(text: "Riwayat"),
                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: TabBarView(
                  children: [_buildJadwalTab(), _buildRiwayatTab()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJadwalTab() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF5A3116)),
        );
      }

      final activeJadwal = controller.jadwal
          .where(
            (item) =>
                item["statusKelas"] != "selesai" &&
                item["statusKelas"] != "dibatalkan",
          )
          .toList();

      if (activeJadwal.isEmpty) {
        return _buildEmptyState(
          icon: Icons.calendar_month_outlined,
          title: "Belum Ada Jadwal",
          subtitle:
              "Jadwal pelatihan yang telah Anda pesan akan muncul di halaman ini.",
        );
      }

      return RefreshIndicator(
        color: const Color(0xFF5A3116),
        onRefresh: controller.getJadwal,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          itemCount: activeJadwal.length,
          itemBuilder: (context, index) {
            return _buildJadwalCard(activeJadwal[index]);
          },
        ),
      );
    });
  }

  Widget _buildRiwayatTab() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF5A3116)),
        );
      }

      final historyJadwal = controller.jadwal
          .where(
            (item) =>
                item["statusKelas"] == "selesai" ||
                item["statusKelas"] == "dibatalkan",
          )
          .toList();

      if (historyJadwal.isEmpty) {
        return _buildEmptyState(
          icon: Icons.history_outlined,
          title: "Belum Ada Riwayat",
          subtitle:
              "Riwayat pelatihan yang telah selesai akan muncul di halaman ini.",
        );
      }

      return RefreshIndicator(
        color: const Color(0xFF5A3116),
        onRefresh: controller.getJadwal,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          itemCount: historyJadwal.length,
          itemBuilder: (context, index) {
            return _buildJadwalCard(historyJadwal[index]);
          },
        ),
      );
    });
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 95,
              height: 95,
              decoration: const BoxDecoration(
                color: Color(0xFFF3EAE0),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 46, color: const Color(0xFF5A3116)),
            ),

            const SizedBox(height: 24),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E2723),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildJadwalCard(Map<String, dynamic> item) {
    final status = item["statusKelas"] ?? "";

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: getStatusColor(status).withOpacity(.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status.toUpperCase(),
              style: TextStyle(
                color: getStatusColor(status),
                fontWeight: FontWeight.bold,
                fontSize: 9,
                letterSpacing: 05,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            item["kelas"]?["namaKelas"] ?? "-",
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E2723),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 18,
                color: Color(0xFF5A3116),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  item["pengrajin"]?["name"] ?? "-",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F5F1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xFF5A3116),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Tanggal",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        item["tanggal"] ?? "-",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F5F1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.schedule_outlined,
                        color: Color(0xFF5A3116),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Jam",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        item["jamPelatihan"] ?? "-",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F5F1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF5A3116),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    item["lokasi"] ?? "-",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF3E2723),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (status == "selesai" &&
              (item["sudahReview"] ?? false) == false) ...[
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed(
                    Routes.BERI_RATING,
                    arguments: {
                      "bookingId": item["id"],
                      "pengrajinId": item["pengrajin"]["id"],
                      "pengrajinNama": item["pengrajin"]["name"],
                    },
                  );
                },
                icon: const Icon(Icons.star_rounded),
                label: const Text(
                  "Beri Rating",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB300),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],

          if (status == "selesai" &&
              (item["sudahReview"] ?? false) == true) ...[
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade700),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "Anda sudah memberikan rating.",
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
