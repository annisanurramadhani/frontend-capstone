import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../global_widgets/custom_navbar.dart';
import '../../../../routes/app_pages.dart';
import '../../profil_pengrajin/views/profil_pengrajin_view.dart';
import '../controllers/daftar_pengrajin_controller.dart';

class DaftarPengrajinView extends GetView<DaftarPengrajinController> {
  const DaftarPengrajinView({super.key});

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

          if (controller.pengrajin.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline_rounded,
                    size: 70,
                    color: Color(0xFFD6C2AF),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Belum ada data pengrajin",
                    style: TextStyle(fontSize: 15, color: Color(0xFF8B6347)),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              SizedBox(height: h * 0.018),
              SizedBox(
                height: 56,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Get.offAllNamed(Routes.HALAMAN_UTAMA);
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 22,
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: const Color(0xFF5A3116),
                          size: w * 0.055,
                        ),
                      ),
                    ),

                    Center(
                      child: Text(
                        "Daftar Pengrajin",
                        style: TextStyle(
                          fontSize: w * 0.065,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3E2723),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.RIWAYAT_KELAS);
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 22,
                        icon: Icon(
                          Icons.history,
                          color: const Color(0xFF5A3116),
                          size: w * 0.055,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.004),

              Center(
                child: Text(
                  "Temukan pengrajin terbaik",
                  style: TextStyle(fontSize: w * 0.034, color: Colors.grey),
                ),
              ),

              SizedBox(height: h * 0.02),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                  itemCount: controller.pengrajin.length,
                  itemBuilder: (context, index) {
                    final item = controller.pengrajin[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: h * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.045),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          Get.to(
                            () => const ProfilPengrajinView(),
                            arguments: item,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(w * 0.04),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      w * 0.035,
                                    ),
                                    child:
                                        item["photo"] != null &&
                                                item["photo"].toString().isNotEmpty
                                            ? Image.network(
                                                item["photo"].toString().startsWith("http")
                                                    ? item["photo"]
                                                    : "${ApiProvider.baseUrl}${item["photo"]}",
                                                width: w * 0.20,
                                                height: w * 0.20,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                      return _fotoDefault();
                                                    },
                                              )
                                            : _fotoDefault(),
                                  ),

                                  SizedBox(width: w * 0.035),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["name"] ?? "-",
                                          style: TextStyle(
                                            fontSize: w * 0.043,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF3E2723),
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.amber.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    size: 14,
                                                    color: Colors.amber,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    "${item["rating"] ?? "0"}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(width: 8),

                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF3EAE0),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                item["pengalaman"] ?? "-",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF5A3116),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 10),

                                        Text(
                                          item["deskripsi"] ??
                                              "Pengrajin Anyaman Bambu",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: w * 0.033,
                                            color: Colors.grey,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 18),
                              SizedBox(
                                width: double.infinity,
                                height: h * 0.055,
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
                                      borderRadius: BorderRadius.circular(
                                        w * 0.03,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Lihat Profil",
                                    style: TextStyle(
                                      fontSize: w * 0.036,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _fotoDefault() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF3EAE0),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(Icons.person, size: 40, color: Color(0xFF5A3116)),
    );
  }
}