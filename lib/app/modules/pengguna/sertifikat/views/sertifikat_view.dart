import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_navbar.dart';
import '../controllers/sertifikat_controller.dart';

class SertifikatView extends GetView<SertifikatController> {
  const SertifikatView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF6F1),

        bottomNavigationBar: const CustomNavbar(currentIndex: 3),

        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: h * 0.02),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: SizedBox(
                  height: h * 0.065,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: controller.kembali,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: w * 0.055,
                            color: const Color(0xFF5A3116),
                          ),
                        ),
                      ),

                      Text(
                        "Sertifikat Saya",
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
              Center(
                child: SizedBox(
                  width: w * .82,
                  child: Text(
                    "Sertifikat yang Anda miliki",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w * 0.034,
                      color: Colors.grey,
                      height: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF5A3116),
                      ),
                    );
                  }

                  if (controller.sertifikatList.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: w * 0.22,
                              height: w * 0.22,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF5ECE3),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.workspace_premium_outlined,
                                size: w * 0.11,
                                color: Color(0xFF5A3116),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              "Belum Ada Sertifikat",
                              style: TextStyle(
                                fontSize: w * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E2723),
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              "Selesaikan pelatihan terlebih dahulu\nagar sertifikat dapat diterbitkan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                height: 1.6,
                              ),
                            ),

                            const SizedBox(height: 28),

                            SizedBox(
                              width: w * 0.50,
                              height: h * 0.06,
                              child: ElevatedButton(
                                onPressed: controller.kembali,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5A3116),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  "Mulai Belajar",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(
                      w * 0.05,
                      0,
                      w * 0.05,
                      h * 0.03,
                    ),
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
      ),
    );
  }

  Widget sertifikatCard({
    required BuildContext context,
    required dynamic data,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // CARD SERTIFIKAT
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF5A3116), Color(0xFF8B5E3C)],
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.workspace_premium_rounded,
                  size: 60,
                  color: Colors.white,
                ),

                const SizedBox(height: 14),

                Text(
                  data["kelas"]?["namaKelas"] ?? "-",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Sertifikat Penyelesaian\nPelatihan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 18),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.18),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.greenAccent,
                        size: 18,
                      ),

                      SizedBox(width: 8),

                      Text(
                        "Sertifikat Terbit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F5F2),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: Color(0xFF5A3116),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Pengrajin",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        data["pengrajin"]?["name"] ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F5F2),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xFF5A3116),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Tanggal",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        data["tanggal"] ?? "-",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.find<SertifikatController>().lihatSertifikat(data);
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
                    Get.find<SertifikatController>().unduhPdf(data);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A3116),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Unduh PDF",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
