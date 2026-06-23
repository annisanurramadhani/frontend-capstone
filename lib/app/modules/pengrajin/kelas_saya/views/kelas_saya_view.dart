import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/kelas_saya_controller.dart';
import '../../../../global_widgets/navbar_pengrajin.dart';

class KelasSayaView extends GetView<KelasSayaController> {
  const KelasSayaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F3EF),
        elevation: 0,
        title: const Text(
          "Kelas Saya",
          style: TextStyle(
            color: Color(0xFF5A3116),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.kelasSaya.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada peserta",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadData,
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: controller.kelasSaya.length,
            itemBuilder: (context, index) {
              final item = controller.kelasSaya[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 15),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["namaLengkap"] ?? "-",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5A3116),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.school,
                            size: 18,
                            color: Color(0xFF8B5E3C),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Text(item["kelas"]?["namaKelas"] ?? "-"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 18,
                            color: Color(0xFF8B5E3C),
                          ),

                          const SizedBox(width: 8),

                          Text(item["tanggal"] ?? "-"),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 18,
                            color: Color(0xFF8B5E3C),
                          ),

                          const SizedBox(width: 8),

                          Text(item["jamPelatihan"] ?? "-"),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 18,
                            color: Color(0xFF8B5E3C),
                          ),

                          const SizedBox(width: 8),

                          Text(item["noTelpon"] ?? "-"),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: item["statusKelas"] == "selesai"
                              ? Colors.green.shade100
                              : Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item["statusKelas"] ?? "-",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),

      bottomNavigationBar: const NavbarPengrajin(currentIndex: 0),
    );
  }
}