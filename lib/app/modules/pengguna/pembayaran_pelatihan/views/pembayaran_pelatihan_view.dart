// pembayaran_pelatihan_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pembayaran_pelatihan_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class PembayaranPelatihanView extends GetView<PembayaranPelatihanController> {
  const PembayaranPelatihanView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // PEMBAYARAN PELATIHAN
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Obx(() {
          final pembayaran = controller.pembayaran;

          final metode = controller.metode;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: EdgeInsets.all(size.width * 0.055),

            child: Column(
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
                          "Pembayaran",

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

                SizedBox(height: size.height * 0.025),

                // ALERT
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBF5),

                    borderRadius: BorderRadius.circular(22),

                    border: Border.all(color: Colors.orange.shade200),
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Icon(Icons.access_time, color: Colors.orange),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Text(
                          "Selesaikan pembayaran sebelum waktu habis.",

                          style: TextStyle(
                            fontSize: size.width * 0.038,

                            height: 1.6,

                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.025),

                // TOTAL
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Total Pembayaran",

                        style: TextStyle(fontSize: 18, color: Colors.brown),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        controller.totalPembayaran,

                        style: TextStyle(
                          fontSize: size.width * 0.09,

                          fontWeight: FontWeight.bold,

                          color: const Color(0xFF3E2723),
                        ),
                      ),

                      const SizedBox(height: 22),

                      Row(
                        children: [
                          const Text(
                            "Order ID",

                            style: TextStyle(color: Colors.brown),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Text(
                              controller.orderId,

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: controller.salinOrderId,

                            child: const Icon(Icons.copy),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.025),

                // METODE
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Metode Pembayaran",

                        style: TextStyle(
                          fontSize: 22,

                          fontWeight: FontWeight.bold,

                          color: Color(0xFF3E2723),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(18),

                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBF7),

                          borderRadius: BorderRadius.circular(22),
                        ),

                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,

                              decoration: BoxDecoration(
                                color: const Color(0xFFF3EAE0),

                                borderRadius: BorderRadius.circular(18),
                              ),

                              child: const Icon(
                                Icons.qr_code,

                                color: Color(0xFF5A3116),
                              ),
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

                      const SizedBox(height: 24),

                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown.shade200),

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Image.network(
                            "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=PEMBAYARAN-ANYAMAN",

                            width: 220,

                            height: 220,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.025),

                // TIMER
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    children: [
                      const Text(
                        "Sisa Waktu Pembayaran",

                        style: TextStyle(
                          fontSize: 20,

                          fontWeight: FontWeight.bold,

                          color: Color(0xFF3E2723),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Obx(
                            () => Text(
                              controller.menit.value.toString().padLeft(2, "0"),

                              style: TextStyle(
                                fontSize: size.width * 0.13,

                                fontWeight: FontWeight.bold,

                                color: Colors.orange,
                              ),
                            ),
                          ),

                          Text(
                            " : ",

                            style: TextStyle(
                              fontSize: size.width * 0.13,

                              fontWeight: FontWeight.bold,

                              color: Colors.orange,
                            ),
                          ),

                          Obx(
                            () => Text(
                              controller.detik.value.toString().padLeft(2, "0"),

                              style: TextStyle(
                                fontSize: size.width * 0.13,

                                fontWeight: FontWeight.bold,

                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.025),

                // STATUS
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Status Pembayaran",

                        style: TextStyle(
                          fontSize: 22,

                          fontWeight: FontWeight.bold,

                          color: Color(0xFF3E2723),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,

                          vertical: 10,
                        ),

                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),

                          borderRadius: BorderRadius.circular(14),
                        ),

                        child: const Text(
                          "Menunggu Pembayaran",

                          style: TextStyle(
                            color: Colors.orange,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,

                        height: 60,

                        child: ElevatedButton(
                          onPressed: controller.cekStatusPembayaran,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5A3116),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          child: Text(
                            "Cek Status Pembayaran",

                            style: TextStyle(
                              fontSize: size.width * 0.042,

                              fontWeight: FontWeight.bold,

                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
