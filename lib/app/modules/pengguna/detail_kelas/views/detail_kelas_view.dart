// detail_kelas_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_kelas_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class DetailKelasView extends GetView<DetailKelasController> {
  const DetailKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // DETAIL KELAS
      bottomNavigationBar: const CustomNavbar(currentIndex: 0),

      body: SafeArea(
        child: Obx(() {
          final data = controller.detailKelas;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: EdgeInsets.all(size.width * 0.055),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
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

                    Expanded(
                      child: Center(
                        child: Text(
                          "Detail Kelas",

                          style: TextStyle(
                            fontSize: size.width * 0.07,

                            fontWeight: FontWeight.bold,

                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),

                SizedBox(height: size.height * 0.03),

                // IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),

                  child: Image.network(
                    data["gambar"] ?? "",

                    width: double.infinity,

                    height: size.height * 0.3,

                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: size.height * 0.3,

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(28),
                        ),

                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,

                            size: 60,

                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // STATUS
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,

                    vertical: 10,
                  ),

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

                SizedBox(height: size.height * 0.025),

                // NAMA KELAS
                Text(
                  data["nama_kelas"] ?? "",

                  style: TextStyle(
                    fontSize: size.width * 0.075,

                    fontWeight: FontWeight.bold,

                    color: const Color(0xFF3E2723),

                    height: 1.4,
                  ),
                ),

                SizedBox(height: size.height * 0.025),

                // CARD INFO
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    children: [
                      infoRow(
                        Icons.calendar_month_outlined,

                        "Tanggal",

                        data["tanggal"] ?? "",
                      ),

                      const SizedBox(height: 20),

                      infoRow(Icons.access_time, "Jam", data["jam"] ?? ""),

                      const SizedBox(height: 20),

                      infoRow(
                        Icons.location_on_outlined,

                        "Lokasi",

                        data["lokasi"] ?? "",
                      ),

                      const SizedBox(height: 20),

                      infoRow(
                        Icons.person_outline,

                        "Pengrajin",

                        data["pengrajin"] ?? "",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // DESKRIPSI
                Text(
                  "Deskripsi",

                  style: TextStyle(
                    fontSize: size.width * 0.06,

                    fontWeight: FontWeight.bold,

                    color: const Color(0xFF3E2723),
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Text(
                    data["deskripsi"] ?? "",

                    style: const TextStyle(
                      fontSize: 17,

                      color: Colors.black87,

                      height: 1.8,
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget infoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          width: 50,
          height: 50,

          decoration: const BoxDecoration(
            color: Color(0xFFF3EAE0),

            shape: BoxShape.circle,
          ),

          child: Icon(icon, color: const Color(0xFF5A3116)),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style: const TextStyle(fontSize: 15, color: Colors.brown),
              ),

              const SizedBox(height: 6),

              Text(
                value,

                style: const TextStyle(
                  fontSize: 18,

                  fontWeight: FontWeight.bold,

                  color: Color(0xFF3E2723),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
