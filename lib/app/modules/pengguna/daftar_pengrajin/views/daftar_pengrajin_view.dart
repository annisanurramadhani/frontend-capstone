import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profil_pengrajin/views/profil_pengrajin_view.dart';
import '../../../../routes/app_pages.dart';
import '../../../../data/providers/api_provider.dart';
import '../controllers/daftar_pengrajin_controller.dart';

class DaftarPengrajinView extends GetView<DaftarPengrajinController> {
  const DaftarPengrajinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF3E2723),
            size: 20,
          ),
        ),
        title: const Text(
          "Daftar Pengrajin",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.RIWAYAT_KELAS),
            icon: const Icon(Icons.history, color: Color(0xFF3E2723)),
            tooltip: "Riwayat Kelas",
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF5A3116)),
          );
        }

        if (controller.pengrajin.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada pengrajin",
              style: TextStyle(fontSize: 14, color: Colors.brown),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.pengrajin.length,
          itemBuilder: (context, index) {
            final item = controller.pengrajin[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
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
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FOTO
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:
                            item["photo"] != null &&
                                item["photo"].toString().isNotEmpty
                            ? Image.network(
                                "${ApiProvider.baseUrl}${item['photo']}",
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stack) =>
                                    _fotoDefault(),
                              )
                            : _fotoDefault(),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"] ?? "-",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E2723),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Pengalaman: ${item["pengalaman"] ?? "-"}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.brown,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${item["rating"] ?? "-"}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3E2723),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => const ProfilPengrajinView(),
                          arguments: item,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A3116),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "Lihat Profil",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _fotoDefault() {
    return Container(
      width: 64,
      height: 64,
      decoration: const BoxDecoration(
        color: Color(0xFFF3EAE0),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, color: Color(0xFF5A3116), size: 32),
    );
  }
}
