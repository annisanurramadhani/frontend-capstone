// konfirmasi_pembayaran_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/konfirmasi_pembayaran_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class KonfirmasiPembayaranView extends GetView<KonfirmasiPembayaranController> {
  const KonfirmasiPembayaranView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // KONFIRMASI PEMBAYARAN
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.dataKelas;

          final pengrajin = data["pengrajin"];

          final tanggal = data["tanggal"];

          final jam = data["jam"];

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
                          "Konfirmasi",

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

                // CARD DETAIL
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),

                            child: Image.asset(
                              pengrajin["foto"],

                              width: 110,

                              height: 130,

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

                                const SizedBox(height: 16),

                                OutlinedButton(
                                  onPressed: controller.lihatProfil,

                                  child: const Text("Lihat Profil"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.03),

                      Divider(color: Colors.brown.shade100),

                      SizedBox(height: size.height * 0.025),

                      Row(
                        children: [
                          Container(
                            width: 65,
                            height: 65,

                            decoration: BoxDecoration(
                              color: const Color(0xFFF3EAE0),

                              borderRadius: BorderRadius.circular(18),
                            ),

                            child: const Icon(
                              Icons.calendar_month,

                              color: Color(0xFF5A3116),
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "${tanggal["hari"]}, ${tanggal["tanggal"]}",

                                  style: TextStyle(
                                    fontSize: size.width * 0.048,

                                    fontWeight: FontWeight.bold,

                                    color: const Color(0xFF3E2723),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  jam["jam"],

                                  style: TextStyle(
                                    fontSize: size.width * 0.04,

                                    color: Colors.brown,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.03),

                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBF7),

                          borderRadius: BorderRadius.circular(22),
                        ),

                        child: Column(
                          children: [
                            pembayaranRow("Harga Kelas", "Rp200.000"),

                            const SizedBox(height: 14),

                            pembayaranRow("Biaya Layanan", "Rp5.000"),

                            const SizedBox(height: 16),

                            Divider(color: Colors.brown.shade100),

                            const SizedBox(height: 16),

                            pembayaranRow("Total", "Rp205.000", total: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                Text(
                  "Metode Pembayaran",

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

                  itemCount: controller.metodePembayaranList.length,

                  itemBuilder: (context, index) {
                    final metode = controller.metodePembayaranList[index];

                    final isSelected = controller.selectedMetode == metode;

                    return GestureDetector(
                      onTap: () {
                        controller.pilihMetode(metode);
                      },

                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),

                        padding: const EdgeInsets.all(18),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(22),

                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF5A3116)
                                : Colors.brown.shade100,

                            width: 2,
                          ),
                        ),

                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,

                              color: const Color(0xFF5A3116),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    metode["nama"],

                                    style: TextStyle(
                                      fontSize: size.width * 0.045,

                                      fontWeight: FontWeight.bold,

                                      color: const Color(0xFF3E2723),
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    metode["subtitle"],

                                    style: TextStyle(
                                      fontSize: size.width * 0.036,

                                      color: Colors.brown,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: size.height * 0.03),

                SizedBox(
                  width: double.infinity,

                  height: 60,

                  child: ElevatedButton(
                    onPressed: controller.bayar,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A3116),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    child: Text(
                      "Bayar Sekarang",

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

  Widget pembayaranRow(String title, String value, {bool total = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,

          style: TextStyle(
            fontSize: total ? 20 : 16,

            fontWeight: total ? FontWeight.bold : FontWeight.w500,

            color: const Color(0xFF3E2723),
          ),
        ),

        Text(
          value,

          style: TextStyle(
            fontSize: total ? 24 : 16,

            fontWeight: FontWeight.bold,

            color: const Color(0xFF5A3116),
          ),
        ),
      ],
    );
  }
}
