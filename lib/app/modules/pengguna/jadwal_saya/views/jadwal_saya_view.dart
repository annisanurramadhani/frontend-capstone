// jadwal_saya_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/jadwal_saya_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class JadwalSayaView extends GetView<JadwalSayaController> {
  const JadwalSayaView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // JADWAL SAYA
      bottomNavigationBar: const CustomNavbar(currentIndex: 0),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.055),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Jadwal Saya",

                style: TextStyle(
                  fontSize: size.width * 0.09,

                  fontWeight: FontWeight.bold,

                  color: const Color(0xFF3E2723),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              Obx(
                () => Row(
                  children: [
                    tabItem(title: "Jadwal", index: 0),

                    tabItem(title: "Riwayat", index: 1),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.03),

              Expanded(
                child: Obx(() {
                  if (controller.selectedTab.value == 0) {
                    if (controller.jadwalList.isEmpty) {
                      return emptyState(
                        icon: Icons.calendar_month_outlined,

                        title: "Belum Ada Jadwal",

                        subtitle:
                            "Jadwal kelas yang kamu pesan akan muncul di sini.",
                      );
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),

                      itemCount: controller.jadwalList.length,

                      itemBuilder: (context, index) {
                        final data = controller.jadwalList[index];

                        return jadwalCard(data: data);
                      },
                    );
                  }

                  if (controller.riwayatList.isEmpty) {
                    return emptyState(
                      icon: Icons.history,

                      title: "Belum Ada Riwayat",

                      subtitle:
                          "Riwayat kelas yang sudah selesai akan muncul di sini.",
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),

                    itemCount: controller.riwayatList.length,

                    itemBuilder: (context, index) {
                      final data = controller.riwayatList[index];

                      return jadwalCard(data: data);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget jadwalCard({required dynamic data}) {
    return GestureDetector(
      onTap: () {
        controller.lihatDetail(data);
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 22),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(28),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data["nama_kelas"] ?? "",

                    style: const TextStyle(
                      fontSize: 24,

                      fontWeight: FontWeight.bold,

                      color: Color(0xFF3E2723),
                    ),
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios,

                  color: Color(0xFF5A3116),

                  size: 18,
                ),
              ],
            ),

            const SizedBox(height: 18),

            infoRow(Icons.calendar_month_outlined, data["tanggal"] ?? ""),

            const SizedBox(height: 12),

            infoRow(Icons.access_time, data["jam"] ?? ""),

            const SizedBox(height: 12),

            infoRow(Icons.person_outline, data["pengrajin"] ?? ""),

            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

              decoration: BoxDecoration(
                color: const Color(0xFFF3EAE0),

                borderRadius: BorderRadius.circular(14),
              ),

              child: Text(
                data["status"] ?? "",

                style: const TextStyle(
                  fontSize: 16,

                  fontWeight: FontWeight.bold,

                  color: Color(0xFF5A3116),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            width: 110,
            height: 110,

            decoration: const BoxDecoration(
              color: Color(0xFFF3EAE0),

              shape: BoxShape.circle,
            ),

            child: Icon(icon, size: 50, color: const Color(0xFF5A3116)),
          ),

          const SizedBox(height: 24),

          Text(
            title,

            style: const TextStyle(
              fontSize: 28,

              fontWeight: FontWeight.bold,

              color: Color(0xFF3E2723),
            ),
          ),

          const SizedBox(height: 14),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),

            child: Text(
              subtitle,

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 18,

                color: Colors.brown,

                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabItem({required String title, required int index}) {
    final isActive = controller.selectedTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.gantiTab(index);
        },

        child: Column(
          children: [
            Text(
              title,

              style: TextStyle(
                fontSize: 22,

                fontWeight: FontWeight.bold,

                color: isActive ? const Color(0xFF3E2723) : Colors.grey,
              ),
            ),

            const SizedBox(height: 14),

            Container(
              height: 3,

              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF5A3116) : Colors.transparent,

                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.brown),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,

            style: const TextStyle(fontSize: 17, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget bottomNavbar() {
    return Container(
      height: 85,

      decoration: const BoxDecoration(color: Colors.white),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          navbarItem(
            icon: Icons.home_outlined,

            title: "Beranda",

            active: false,

            onTap: controller.keBeranda,
          ),

          navbarItem(
            icon: Icons.search,

            title: "Belajar",

            active: false,

            onTap: controller.keCariKelas,
          ),

          navbarItem(
            icon: Icons.calendar_month,

            title: "Jadwal",

            active: true,

            onTap: () {},
          ),

          navbarItem(
            icon: Icons.person_outline,

            title: "Profil",

            active: false,

            onTap: controller.keProfil,
          ),
        ],
      ),
    );
  }

  Widget navbarItem({
    required IconData icon,
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(
            icon,

            size: 28,

            color: active ? const Color(0xFF5A3116) : Colors.grey,
          ),

          const SizedBox(height: 6),

          Text(
            title,

            style: TextStyle(
              fontSize: 15,

              fontWeight: active ? FontWeight.bold : FontWeight.normal,

              color: active ? const Color(0xFF5A3116) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
