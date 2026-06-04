// tahapan_kelas_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tahapan_kelas_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class TahapanKelasView extends GetView<TahapanKelasController> {
  const TahapanKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // TAHAPAN KELAS
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Obx(() {
          final data = controller.pengrajin;

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
                          "Tahapan Kelas",

                          style: TextStyle(
                            fontSize: size.width * 0.065,

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

                // CARD PENGRAJIN
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),

                        child: Image.asset(
                          data["foto"],

                          width: 90,
                          height: 90,

                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              data["nama"],

                              style: TextStyle(
                                fontSize: size.width * 0.05,

                                fontWeight: FontWeight.bold,

                                color: const Color(0xFF3E2723),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              data["lokasi"],

                              style: TextStyle(
                                fontSize: size.width * 0.038,

                                color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // TITLE
                Text(
                  "Tahapan Pemesanan",

                  style: TextStyle(
                    fontSize: size.width * 0.06,

                    fontWeight: FontWeight.bold,

                    color: const Color(0xFF3E2723),
                  ),
                ),

                SizedBox(height: size.height * 0.025),

                // STEP LIST
                ListView.builder(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: controller.tahapanList.length,

                  itemBuilder: (context, index) {
                    final step = controller.tahapanList[index];

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,

                              decoration: BoxDecoration(
                                color: index == 0
                                    ? const Color(0xFF5A3116)
                                    : Colors.white,

                                shape: BoxShape.circle,
                              ),

                              child: Center(
                                child: Text(
                                  "${index + 1}",

                                  style: TextStyle(
                                    fontSize: 22,

                                    fontWeight: FontWeight.bold,

                                    color: index == 0
                                        ? Colors.white
                                        : const Color(0xFF5A3116),
                                  ),
                                ),
                              ),
                            ),

                            if (index != controller.tahapanList.length - 1)
                              Container(
                                width: 3,
                                height: 70,

                                color: const Color(0xFFE0D2C3),
                              ),
                          ],
                        ),

                        const SizedBox(width: 18),

                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 24),

                            padding: const EdgeInsets.all(18),

                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(24),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  step["title"],

                                  style: TextStyle(
                                    fontSize: size.width * 0.048,

                                    fontWeight: FontWeight.bold,

                                    color: const Color(0xFF3E2723),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Text(
                                  step["subtitle"],

                                  style: TextStyle(
                                    fontSize: size.width * 0.038,

                                    color: Colors.brown,

                                    height: 1.7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: size.height * 0.03),

                // BUTTON
                SizedBox(
                  width: double.infinity,

                  height: 60,

                  child: ElevatedButton(
                    onPressed: controller.lanjutPilihJadwal,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A3116),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    child: Text(
                      "Lanjut Pilih Jadwal",

                      style: TextStyle(
                        fontSize: size.width * 0.043,

                        fontWeight: FontWeight.bold,

                        color: Colors.white,
                      ),
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
}
