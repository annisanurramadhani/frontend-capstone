// pilih_jadwal_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pilih_jadwal_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class PilihJadwalView extends GetView<PilihJadwalController> {
  const PilihJadwalView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // PILIH JADWAL
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final pengrajin = controller.pengrajin;

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
                          "Pilih Jadwal",

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
                          pengrajin["foto"],

                          width: 100,
                          height: 120,

                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              pengrajin["nama"],

                              style: TextStyle(
                                fontSize: size.width * 0.055,

                                fontWeight: FontWeight.bold,

                                color: const Color(0xFF3E2723),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              pengrajin["lokasi"],

                              style: TextStyle(
                                fontSize: size.width * 0.038,

                                color: Colors.brown,
                              ),
                            ),

                            const SizedBox(height: 12),

                            OutlinedButton(
                              onPressed: controller.lihatProfil,

                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF5A3116),
                                ),
                              ),

                              child: const Text(
                                "Lihat Profil",

                                style: TextStyle(color: Color(0xFF5A3116)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // TANGGAL
                Text(
                  "Pilih Tanggal",

                  style: TextStyle(
                    fontSize: size.width * 0.06,

                    fontWeight: FontWeight.bold,

                    color: const Color(0xFF3E2723),
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                SizedBox(
                  height: 90,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,

                    itemCount: controller.tanggalList.length,

                    itemBuilder: (context, index) {
                      final data = controller.tanggalList[index];

                      final isSelected = controller.selectedTanggal == data;

                      return GestureDetector(
                        onTap: () {
                          controller.pilihTanggal(data);
                        },

                        child: Container(
                          width: 85,

                          margin: const EdgeInsets.only(right: 14),

                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF5A3116)
                                : Colors.white,

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(
                                data["hari"],

                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF3E2723),
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                data["tanggal"],

                                style: TextStyle(
                                  fontSize: 18,

                                  fontWeight: FontWeight.bold,

                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF3E2723),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // JAM
                Text(
                  "Pilih Jam",

                  style: TextStyle(
                    fontSize: size.width * 0.06,

                    fontWeight: FontWeight.bold,

                    color: const Color(0xFF3E2723),
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                ListView.builder(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: controller.jamList.length,

                  itemBuilder: (context, index) {
                    final data = controller.jamList[index];

                    final isSelected = controller.selectedJam == data;

                    return GestureDetector(
                      onTap: () {
                        controller.pilihJam(data);
                      },

                      child: Container(
                        margin: const EdgeInsets.only(bottom: 18),

                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(24),

                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF5A3116)
                                : Colors.transparent,

                            width: 2,
                          ),
                        ),

                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    data["jam"],

                                    style: TextStyle(
                                      fontSize: size.width * 0.05,

                                      fontWeight: FontWeight.bold,

                                      color: const Color(0xFF3E2723),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    "Tersedia ${data["kursi"]} kursi",

                                    style: TextStyle(
                                      fontSize: size.width * 0.038,

                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            if (isSelected)
                              const Icon(
                                Icons.check_circle,

                                color: Color(0xFF5A3116),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: size.height * 0.03),

                // JADWAL TERPILIH
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Jadwal Dipilih",

                        style: TextStyle(
                          fontSize: 20,

                          fontWeight: FontWeight.bold,

                          color: Color(0xFF3E2723),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        "${controller.selectedTanggal["hari"]}, ${controller.selectedTanggal["tanggal"]}",

                        style: TextStyle(
                          fontSize: size.width * 0.045,

                          color: Colors.brown,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        controller.selectedJam["jam"],

                        style: TextStyle(
                          fontSize: size.width * 0.05,

                          fontWeight: FontWeight.bold,

                          color: const Color(0xFF3E2723),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // BUTTON
                SizedBox(
                  width: double.infinity,

                  height: 60,

                  child: ElevatedButton(
                    onPressed: controller.lanjutKonfirmasi,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A3116),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    child: Text(
                      "Lanjut Konfirmasi",

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
