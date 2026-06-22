import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sertifikat_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class SertifikatView extends GetView<SertifikatController> {
  const SertifikatView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: controller.kembali,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF3E2723),
            size: 20,
          ),
        ),
        title: const Text(
          "Sertifikat Saya",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBar: const CustomNavbar(currentIndex: 2),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 2),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.055),
              child: Text(
                "Sertifikat yang telah Anda dapatkan akan muncul di halaman ini.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.03,
                  color: Colors.brown,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.sertifikatList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.workspace_premium_outlined,
                          size: 90,
                          color: Colors.brown.shade300,
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Belum ada sertifikat",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Selesaikan kelas terlebih dahulu",
                          style: TextStyle(fontSize: 16, color: Colors.brown),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.sertifikatList.length,
                  itemBuilder: (context, index) {
                    return sertifikatCard(
                      context: context,
                      data: controller.sertifikatList[index],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget sertifikatCard({
    required BuildContext context,
    required dynamic data,
  }) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GAMBAR SERTIFIKAT
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF5A3116), Color(0xFF8B5E3C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.white,
                  size: 60,
                ),

                const SizedBox(height: 12),

                Text(
                  data["kelas"]?["namaKelas"] ?? "-",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Sertifikat Selesai Platihan",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 20,
                color: Color(0xFF5A3116),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Pengrajin : ${data["pengrajin"]?["name"] ?? "-"}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 20,
                color: Color(0xFF5A3116),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Tanggal : ${data["tanggal"] ?? "-"}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    controller.lihatSertifikat(data);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF5A3116)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Lihat",
                    style: TextStyle(
                      color: Color(0xFF5A3116),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.unduhPdf(data);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A3116),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Unduh PDF",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
