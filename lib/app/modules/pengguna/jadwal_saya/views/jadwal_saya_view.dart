import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_navbar.dart';
import '../controllers/jadwal_saya_controller.dart';
import '../../../../routes/app_pages.dart';

class JadwalSayaView extends GetView<JadwalSayaController> {
  const JadwalSayaView({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case "terjadwal":
        return Colors.blue;
      case "selesai":
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFDF8F3),

        appBar: AppBar(
          backgroundColor: const Color(0xFFFDF8F3),
          elevation: 0,
          centerTitle: true,

          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF3E2723),
              size: 20,
            ),
          ),

          title: const Text(
            "Jadwal Saya",
            style: TextStyle(
              color: Color(0xFF3E2723),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          iconTheme: const IconThemeData(color: Color(0xFF5A3116)),

          bottom: const TabBar(
            labelColor: Color(0xFF5A3116),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF5A3116),
            indicatorWeight: 2.5,
            tabs: [
              Tab(text: "Jadwal"),
              Tab(text: "Riwayat"),
            ],
          ),
        ),

        body: TabBarView(children: [_buildJadwalTab(), _buildRiwayatTab()]),

        bottomNavigationBar: const CustomNavbar(currentIndex: 0),
      ),
    );
  }

  Widget _buildJadwalTab() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF8B5E3C)),
        );
      }

      // Filter hanya jadwal yang belum selesai / dibatalkan
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
          subtitle: "Jadwal kelas yang kamu pesan akan muncul di sini.",
        );
      }

      return RefreshIndicator(
        onRefresh: controller.getJadwal,
        color: const Color(0xFF8B5E3C),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          itemCount: activeJadwal.length,
          itemBuilder: (context, index) =>
              _buildJadwalCard(activeJadwal[index]),
        ),
      );
    });
  }

  Widget _buildRiwayatTab() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF8B5E3C)),
        );
      }

      // Filter jadwal yang sudah selesai atau dibatalkan
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
          subtitle: "Riwayat kelas yang telah selesai akan muncul di sini.",
        );
      }

      return RefreshIndicator(
        onRefresh: controller.getJadwal,
        color: const Color(0xFF8B5E3C),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          itemCount: historyJadwal.length,
          itemBuilder: (context, index) =>
              _buildJadwalCard(historyJadwal[index]),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 42, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E2723),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJadwalCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama kelas + badge status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item["kelas"]?["namaKelas"] ?? "-",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5A3116),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: getStatusColor(
                    item["statusKelas"] ?? "",
                  ).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  (item["statusKelas"] ?? "menunggu").toString().toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: getStatusColor(item["statusKelas"] ?? ""),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFEEE8E0)),
          const SizedBox(height: 12),

          _buildInfoRow(
            Icons.person_outline,
            item["pengrajin"]?["name"] ?? "-",
          ),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.calendar_today_outlined, item["tanggal"] ?? "-"),
          const SizedBox(height: 8),
          _buildInfoRow(
            Icons.access_time_outlined,
            item["jamPelatihan"] ?? "-",
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            Icons.location_on_outlined,
            item["lokasi"] ?? "Balai Desa Dukuhsembung",
            isMultiLine: true,
          ),

          // Tombol rating / sudah review
          if (item["statusKelas"] == "selesai" &&
              (item["sudahReview"] ?? false) == false) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
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
                icon: const Icon(Icons.star, color: Colors.white, size: 18),
                label: const Text(
                  "Beri Rating",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB300),
                  minimumSize: const Size.fromHeight(44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],

          if ((item["sudahReview"] ?? false) == true) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 18),
                  SizedBox(width: 8),
                  Text(
                    "Anda sudah memberikan rating",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool isMultiLine = false}) {
    return Row(
      crossAxisAlignment: isMultiLine
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF8B5E3C)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: Color(0xFF4A4A4A)),
          ),
        ),
      ],
    );
  }
}
