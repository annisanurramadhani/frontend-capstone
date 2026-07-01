import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_navbar.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/riwayat_kelas_controller.dart';

class RiwayatKelasView extends GetView<RiwayatKelasController> {
  const RiwayatKelasView({super.key});

  String _formatRupiah(dynamic value) {
    final angka = (value ?? 0).toString();
    return angka.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),

      bottomNavigationBar: const CustomNavbar(currentIndex: -1),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF5A3116)),
            );
          }

          if (controller.bookings.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_rounded,
                    size: 72,
                    color: Color(0xFFD8C6B6),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Belum ada riwayat kelas",
                    style: TextStyle(fontSize: 15, color: Color(0xFF8B6347)),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            color: Color(0xFF5A3116),
            onRefresh: controller.getRiwayat,
            child: Column(
              children: [
                SizedBox(height: h * 0.018),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: w * 0.055,
                            color: Color(0xFF5A3116),
                          ),
                        ),
                      ),

                      Transform.translate(
                        offset: Offset(0, h * 0.008),
                        child: Column(
                          children: [
                            Text(
                              "Riwayat Pesan Kelas",
                              style: TextStyle(
                                fontSize: w * 0.065,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3E2723),
                              ),
                            ),

                            SizedBox(height: h * 0.002),

                            Text(
                              "Semua kelas yang pernah Anda ikuti",
                              style: TextStyle(
                                fontSize: w * 0.034,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.bookings.length,
                    itemBuilder: (context, index) {
                      final item = controller.bookings[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 58,
                                  height: 58,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3EAE0),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.menu_book_rounded,
                                    color: Color(0xFF5A3116),
                                    size: 28,
                                  ),
                                ),

                                const SizedBox(width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item["namaKelas"] ?? "-",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF3E2723),
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        item["pengrajinNama"] ?? "-",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF8B6347),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                _statusBadge(item["statusBayar"] ?? ""),
                              ],
                            ),

                            const SizedBox(height: 18),

                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                  color: Color(0xFF8B6347),
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: Text(
                                    item["tanggal"] ?? "-",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF3E2723),
                                    ),
                                  ),
                                ),

                                const Icon(
                                  Icons.access_time_rounded,
                                  size: 18,
                                  color: Color(0xFF8B6347),
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  item["jamPelatihan"] ?? "-",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF3E2723),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            Row(
                              children: [
                                const Icon(
                                  Icons.payments_outlined,
                                  size: 18,
                                  color: Color(0xFF8B6347),
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  item["metodeBayar"] ?? "-",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF3E2723),
                                  ),
                                ),

                                const Spacer(),

                                Text(
                                  "Rp ${_formatRupiah(item['totalBayar'])}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5A3116),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            Text(
                              "Order ID",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              item["orderId"] ?? "-",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8B6347),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _statusBadge(String status) {
    final bool lunas =
        status.toLowerCase() == "lunas" || status.toLowerCase() == "settlement";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: lunas ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        lunas ? "Lunas" : "Menunggu",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: lunas ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
        ),
      ),
    );
  }
}