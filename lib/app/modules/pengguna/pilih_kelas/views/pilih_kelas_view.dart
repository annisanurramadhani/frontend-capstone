import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_navbar.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/pilih_kelas_controller.dart';

class PilihKelasView extends GetView<PilihKelasController> {
  const PilihKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    final pengrajin = Get.arguments;
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),

      bottomNavigationBar: const CustomNavbar(currentIndex: -1),

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: h * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: SizedBox(
                height: 56,
                child: Row(
                  children: [
                    SizedBox(
                      width: 48,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 22,
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: w * 0.055,
                          color: const Color(0xFF5A3116),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "Pilih Kelas",
                          style: TextStyle(
                            fontSize: w * 0.065,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.004),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.10),
              child: Text(
                "Pilih kelas pelatihan yang ingin Anda ikuti",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: w * 0.034,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
            ),

            SizedBox(height: h * 0.02),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF5A3116)),
                  );
                }
                if (controller.kelas.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: w * 0.22,
                            height: w * 0.22,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF3EAE0),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.school_outlined,
                              size: w * 0.11,
                              color: Color(0xFF5A3116),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "Belum Ada Kelas",
                            style: TextStyle(
                              fontSize: w * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2723),
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Kelas pelatihan akan muncul\npada halaman ini.",
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
                  itemCount: controller.kelas.length,
                  itemBuilder: (context, index) {
                    final item = controller.kelas[index];

                    return kelasCard(item: item, pengrajin: pengrajin);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget kelasCard({required dynamic item, required dynamic pengrajin}) {
    final bool isUnlocked = item["unlocked"] ?? false;

    return Opacity(
      opacity: isUnlocked ? 1 : 0.6,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge Level
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _badgeColor(item["namaKelas"]),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                item["namaKelas"] ?? "-",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              item["deskripsi"] ?? "-",
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF3E2723),
                height: 1.6,
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                const Icon(
                  Icons.schedule_rounded,
                  size: 18,
                  color: Color(0xFF5A3116),
                ),

                const SizedBox(width: 8),

                Text(
                  item["durasi"] ?? "-",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Color(0xFF5A3116),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    item["lokasi"] ?? "-",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Divider(color: Colors.grey.shade300, height: 1),

            const SizedBox(height: 18),

            Text(
              "Rp ${item["harga"]}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5A3116),
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (!isUnlocked) {
                    Get.snackbar(
                      "Kelas Terkunci",
                      "Selesaikan kelas sebelumnya terlebih dahulu.",
                    );
                    return;
                  }

                  Get.toNamed(
                    Routes.PESAN_PELATIHAN,
                    arguments: {"pengrajin": pengrajin, "kelas": item},
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isUnlocked
                      ? const Color(0xFF5A3116)
                      : Colors.grey,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  isUnlocked ? "Pilih Kelas" : "Kelas Terkunci",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _badgeColor(String? namaKelas) {
    if (namaKelas == null) {
      return const Color(0xFF5A3116);
    }

    final nama = namaKelas.toLowerCase();

    if (nama.contains("pemula")) {
      return Colors.green;
    }

    if (nama.contains("menengah")) {
      return Colors.orange;
    }

    if (nama.contains("lanjutan")) {
      return Colors.red;
    }

    return const Color(0xFF5A3116);
  }
}
