import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/halaman_pengrajin_controller.dart';
import '../../../../global_widgets/navbar_pengrajin.dart';

class HalamanPengrajinView extends GetView<HalamanPengrajinController> {
  const HalamanPengrajinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: controller.loadData,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildProfile(),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _statCard(
                        title: "Peserta",
                        value: controller.totalPeserta.value.toString(),
                        icon: Icons.groups,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _statCard(
                        title: "Rating",
                        value: controller.rating.value.toString(),
                        icon: Icons.star,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                const Text(
                  "Jadwal Hari Ini",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                ...controller.jadwalHariIni.map(
                  (jadwal) => Card(
                    child: ListTile(
                      title: Text(jadwal["namaKelas"]),
                      subtitle: Text(
                        "${jadwal["jamMulai"]} - ${jadwal["jamSelesai"]}",
                      ),
                      trailing: Text("${jadwal["jumlahPeserta"]} Peserta"),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),

      bottomNavigationBar: const NavbarPengrajin(currentIndex: 1),
    );
  }

  Widget _buildProfile() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EF),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF5A3116)),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          Text(title),
        ],
      ),
    );
  }
}
