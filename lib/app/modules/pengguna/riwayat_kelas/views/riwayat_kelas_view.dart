import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/riwayat_kelas_controller.dart';

class RiwayatKelasView extends GetView<RiwayatKelasController> {
  const RiwayatKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Riwayat Kelas",
          style: TextStyle(
            color: Color(0xFF5A3116),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF5A3116)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF8B5E3C)),
          );
        }

        if (controller.bookings.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 80, color: Colors.grey),
                SizedBox(height: 12),
                Text(
                  "Belum ada riwayat pemesanan",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.getRiwayat,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.bookings.length,
            itemBuilder: (context, index) {
              final item = controller.bookings[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5E3C).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.school_outlined,
                            color: Color(0xFF8B5E3C),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item["namaKelas"] ?? "-",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5A3116),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    const Divider(),

                    const SizedBox(height: 12),

                    _infoRow("Pengrajin", item["pengrajin"] ?? "-"),

                    const SizedBox(height: 8),

                    _infoRow("Tanggal", item["tanggal"] ?? "-"),

                    const SizedBox(height: 8),

                    _infoRow("Jam", item["jamPelatihan"] ?? "-"),

                    const SizedBox(height: 8),

                    _infoRow("Metode", item["metodeBayar"] ?? "-"),

                    const SizedBox(height: 8),

                    _infoRow("Total Bayar", "Rp ${item["totalBayar"]}"),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item["orderId"] ?? "-",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: item["statusBayar"] == "lunas"
                                ? const Color(0xFFD1E7DD)
                                : const Color(0xFFFFF3CD),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item["statusBayar"] == "lunas"
                                ? "Lunas"
                                : "Menunggu",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: item["statusBayar"] == "lunas"
                                  ? const Color(0xFF0A3622)
                                  : const Color(0xFF856404),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _infoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Color(0xFF3E2723),
            ),
          ),
        ),
      ],
    );
  }
}
