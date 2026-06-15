import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

import '../controllers/pilih_kelas_controller.dart';

class PilihKelasView extends GetView<PilihKelasController> {
  const PilihKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    final pengrajin = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),

        elevation: 0,

        centerTitle: true,

        title: const Text("Pilih Kelas"),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.kelas.isEmpty) {
          return const Center(
            child: Text("Belum ada kelas"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),

          itemCount: controller.kelas.length,

          itemBuilder: (context, index) {
            final item = controller.kelas[index];

            final isUnlocked = item["unlocked"] ?? false;

            return Opacity(
              opacity: isUnlocked ? 1 : 0.5,

              child: Container(
                margin: const EdgeInsets.only(bottom: 20),

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(24),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),

                      blurRadius: 10,

                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item["namaKelas"],

                            style: const TextStyle(
                              fontSize: 22,

                              fontWeight: FontWeight.bold,

                              color: Color(0xFF3E2723),
                            ),
                          ),
                        ),

                        if (!isUnlocked)
                          const Icon(
                            Icons.lock,

                            color: Colors.red,
                          ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(item["deskripsi"]),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 18),

                        const SizedBox(width: 6),

                        Text(item["durasi"]),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 18),

                        const SizedBox(width: 6),

                        Expanded(
                          child: Text(item["lokasi"]),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Rp ${item["harga"]}",

                      style: const TextStyle(
                        fontSize: 18,

                        fontWeight: FontWeight.bold,

                        color: Color(0xFF5A3116),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,

                      height: 50,

                      child: ElevatedButton(
                        onPressed: () {
                          if (!isUnlocked) {
                            Get.snackbar(
                              "Kelas Terkunci",
                              "Selesaikan kelas sebelumnya terlebih dahulu",
                            );

                            return;
                          }

                          Get.toNamed(
                            Routes.PESAN_PELATIHAN,

                            arguments: {
                              "pengrajin": pengrajin,
                              "kelas": item,
                            },
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: isUnlocked
                              ? const Color(0xFF5A3116)
                              : Colors.grey,

                          foregroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),

                        child: Text(
                          isUnlocked
                              ? "Pilih Kelas"
                              : "Terkunci",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}