// sertifikat_view.dart

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

      // SERTIFIKAT
      bottomNavigationBar: const CustomNavbar(currentIndex: 2),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.055),

          child: Column(
            children: [
              SizedBox(height: size.height * 0.01),

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
                        "Sertifikat Saya",

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

              SizedBox(height: size.height * 0.025),

              Text(
                "Sertifikat yang telah Anda dapatkan akan muncul di halaman ini.",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: size.width * 0.04,

                  color: Colors.brown,

                  height: 1.6,
                ),
              ),

              SizedBox(height: size.height * 0.03),

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
                              fontSize: 22,

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
                      final data = controller.sertifikatList[index];

                      return sertifikatCard(context: context, data: data);
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
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 22),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                width: 100,

                height: 140,

                decoration: BoxDecoration(
                  color: const Color(0xFFF3EAE0),

                  borderRadius: BorderRadius.circular(18),
                ),

                child: const Icon(
                  Icons.workspace_premium,

                  size: 50,

                  color: Color(0xFF5A3116),
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      data["judul"] ?? "",

                      style: TextStyle(
                        fontSize: size.width * 0.05,

                        fontWeight: FontWeight.bold,

                        color: const Color(0xFF3E2723),
                      ),
                    ),

                    const SizedBox(height: 18),

                    infoItem(
                      icon: Icons.person_outline,

                      title: "Pengrajin",

                      value: data["pengrajin"] ?? "",
                    ),

                    const SizedBox(height: 12),

                    infoItem(
                      icon: Icons.calendar_month_outlined,

                      title: "Tanggal",

                      value: data["tanggal"] ?? "",
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,

                          color: Colors.green,

                          size: 20,
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          "Selesai",

                          style: TextStyle(
                            fontSize: 16,

                            fontWeight: FontWeight.bold,

                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
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

  Widget infoItem({
    required IconData icon,

    required String title,

    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF5A3116)),

        const SizedBox(width: 10),

        Text(
          "$title : ",

          style: const TextStyle(fontSize: 15, color: Colors.brown),
        ),

        Expanded(
          child: Text(
            value,

            style: const TextStyle(
              fontSize: 15,

              fontWeight: FontWeight.w600,

              color: Color(0xFF3E2723),
            ),
          ),
        ),
      ],
    );
  }
}
