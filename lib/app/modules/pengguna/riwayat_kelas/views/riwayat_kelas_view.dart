// riwayat_kelas_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/riwayat_kelas_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class RiwayatKelasView extends GetView<RiwayatKelasController> {
  const RiwayatKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // RIWAYAT KELAS
      bottomNavigationBar: const CustomNavbar(currentIndex: 0),

      body: SafeArea(
        child: Obx(() {
          if (controller.riwayatKelas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.history_outlined,

                    size: size.width * 0.2,

                    color: Colors.brown.shade300,
                  ),

                  SizedBox(height: size.height * 0.02),

                  Text(
                    "Belum Ada Riwayat Kelas",

                    style: TextStyle(
                      fontSize: size.width * 0.055,

                      fontWeight: FontWeight.bold,

                      color: const Color(0xFF3E2723),
                    ),
                  ),

                  SizedBox(height: size.height * 0.01),

                  Text(
                    "Kelas yang selesai akan tampil di sini",

                    style: TextStyle(
                      fontSize: size.width * 0.04,

                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: EdgeInsets.all(size.width * 0.055),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Riwayat Kelas",

                  style: TextStyle(
                    fontSize: size.width * 0.085,

                    fontWeight: FontWeight.bold,

                    color: const Color(0xFF3E2723),
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                Text(
                  "Kelas yang sudah selesai kamu ikuti",

                  style: TextStyle(
                    fontSize: size.width * 0.042,

                    color: Colors.brown,
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                ListView.builder(
                  itemCount: controller.riwayatKelas.length,

                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemBuilder: (context, index) {
                    final kelas = controller.riwayatKelas[index];

                    return GestureDetector(
                      onTap: () {
                        controller.keDetailKelas(kelas);
                      },

                      child: Container(
                        margin: EdgeInsets.only(bottom: size.height * 0.025),

                        padding: EdgeInsets.all(size.width * 0.045),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(28),
                        ),

                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,

                                    vertical: 8,
                                  ),

                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),

                                    borderRadius: BorderRadius.circular(12),
                                  ),

                                  child: const Text(
                                    "Selesai",

                                    style: TextStyle(
                                      color: Colors.green,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const Icon(
                                  Icons.arrow_forward_ios,

                                  size: 18,

                                  color: Color(0xFF5A3116),
                                ),
                              ],
                            ),

                            SizedBox(height: size.height * 0.025),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(22),

                                  child: Image.network(
                                    kelas["gambar"] ?? "",

                                    width: size.width * 0.3,

                                    height: size.width * 0.4,

                                    fit: BoxFit.cover,

                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: size.width * 0.3,

                                        height: size.width * 0.4,

                                        color: Colors.grey.shade200,

                                        child: const Icon(Icons.image_outlined),
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(width: size.width * 0.04),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        kelas["nama_kelas"] ?? "",

                                        style: TextStyle(
                                          fontSize: size.width * 0.055,

                                          fontWeight: FontWeight.bold,

                                          color: const Color(0xFF3E2723),

                                          height: 1.4,
                                        ),
                                      ),

                                      SizedBox(height: size.height * 0.015),

                                      infoRow(
                                        Icons.person_outline,

                                        kelas["pengrajin"] ?? "",
                                      ),

                                      SizedBox(height: size.height * 0.012),

                                      infoRow(
                                        Icons.calendar_month_outlined,

                                        kelas["tanggal"] ?? "",
                                      ),

                                      SizedBox(height: size.height * 0.012),

                                      infoRow(
                                        Icons.access_time,

                                        kelas["jam"] ?? "",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: size.height * 0.025),

                            SizedBox(
                              width: double.infinity,

                              height: 55,

                              child: ElevatedButton(
                                onPressed: () {
                                  controller.beriReview(kelas: kelas);
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5A3116),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),

                                child: Text(
                                  "Beri Review",

                                  style: TextStyle(
                                    fontSize: size.width * 0.043,

                                    fontWeight: FontWeight.bold,

                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: size.height * 0.03),
              ],
            ),
          );
        }),
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

            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
