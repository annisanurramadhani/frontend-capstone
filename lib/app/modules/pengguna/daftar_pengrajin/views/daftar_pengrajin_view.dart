import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../profil_pengrajin/views/profil_pengrajin_view.dart';

import '../controllers/daftar_pengrajin_controller.dart';

class DaftarPengrajinView extends GetView<DaftarPengrajinController> {
  const DaftarPengrajinView({super.key});

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
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E2723)),
        ),
        title: const Text(
          "Daftar Pengrajin",
          style: TextStyle(
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.pengrajin.isEmpty) {
          return const Center(child: Text("Belum ada pengrajin"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.pengrajin.length,
          itemBuilder: (context, index) {
            final item = controller.pengrajin[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(18),
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
                      // FOTO - test pakai Image.network
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:
                            item["photo"] != null &&
                                item["photo"].toString().isNotEmpty
                            ? Image.network(
                                "http://10.223.117.201:3000/uploads/${item['photo']}",
                                width: 76,
                                height: 76,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stack) {
                                  print("ERROR FOTO: $error");
                                  return _fotoDefault();
                                },
                              )
                            : _fotoDefault(),
                      ),

                      const SizedBox(width: 18),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"] ?? "-",
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3E2723),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Pengalaman: ${item["pengalaman"] ?? "-"}",
                              style: TextStyle(
                                fontSize: size.width * 0.038,
                                color: Colors.brown,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "${item["rating"] ?? "-"}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
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
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Lihat Profil",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
      width: 76,
      height: 76,
      decoration: const BoxDecoration(
        color: Color(0xFFF3EAE0),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, color: Color(0xFF5A3116), size: 38),
    );
  }
}
