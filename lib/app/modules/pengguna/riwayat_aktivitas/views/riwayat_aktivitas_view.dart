import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/riwayat_aktivitas_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class RiwayatAktivitasView extends GetView<RiwayatAktivitasController> {
  const RiwayatAktivitasView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      bottomNavigationBar: const CustomNavbar(currentIndex: -1),
      backgroundColor: const Color(0xFFFAF6F1),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

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
                        onPressed: Get.back,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: const Color(0xFF5A3116),
                          size: w * 0.055,
                        ),
                      ),
                    ),

                    Text(
                      "Riwayat Aktivitas",
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

            SizedBox(height: h * 0.003),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 34),
              child: Text(
                "Lihat seluruh aktivitas yang telah Anda lakukan di aplikasi.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.6),
              ),
            ),

            const SizedBox(height: 24),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF5A3116)),
                  );
                }

                if (controller.aktivitas.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF3EAE0),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.history,
                              size: 46,
                              color: Color(0xFF5A3116),
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "Belum Ada Aktivitas",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2723),
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Aktivitas Anda akan muncul\ndi halaman ini.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(w * 0.05, 0, w * 0.05, h * 0.03),
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.aktivitas.length,
                  itemBuilder: (context, index) {
                    final item = controller.aktivitas[index];

                    return aktivitasCard(item);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget aktivitasCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFFF3EAE0),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.history,
              color: Color(0xFF5A3116),
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["judul"] ?? "-",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  item["deskripsi"] ?? "-",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      item["tanggal"] ?? "-",
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),

                    const SizedBox(width: 18),

                    const Icon(
                      Icons.access_time_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      item["jam"] ?? "-",
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
