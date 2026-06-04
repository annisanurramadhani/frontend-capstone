import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_navbar.dart';

import '../controllers/riwayat_aktivitas_controller.dart';

class RiwayatAktivitasView extends GetView<RiwayatAktivitasController> {
  const RiwayatAktivitasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      bottomNavigationBar: const CustomNavbar(currentIndex: 2),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),

          child: Column(
            children: [
              const SizedBox(height: 10),

              // HEADER
              Row(
                children: [
                  IconButton(
                    onPressed: controller.kembali,
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF5A3116),
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        "Riwayat Aktivitas",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 30),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.aktivitasList.isEmpty) {
                    return const Center(
                      child: Text(
                        "Belum ada aktivitas",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.aktivitasList.length,

                    itemBuilder: (context, index) {
                      final data = controller.aktivitasList[index];

                      return aktivitasItem(
                        icon: getIcon(data["icon"]),

                        aktivitas: data["aktivitas"],

                        waktu: data["waktu"],
                      );
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

  Widget aktivitasItem({
    required IconData icon,

    required String aktivitas,

    required String waktu,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,

            decoration: const BoxDecoration(
              color: Color(0xFFF3EAE0),

              shape: BoxShape.circle,
            ),

            child: Icon(icon, size: 34, color: const Color(0xFF5A3116)),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  aktivitas,

                  style: const TextStyle(
                    fontSize: 22,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF3E2723),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  waktu,

                  style: const TextStyle(fontSize: 17, color: Colors.brown),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData getIcon(String icon) {
    switch (icon) {
      case "login":
        return Icons.login;

      case "payment":
        return Icons.payment;

      case "kelas":
        return Icons.menu_book;

      case "produk":
        return Icons.shopping_bag;

      case "profil":
        return Icons.person;

      case "sertifikat":
        return Icons.workspace_premium;

      default:
        return Icons.history;
    }
  }
}
