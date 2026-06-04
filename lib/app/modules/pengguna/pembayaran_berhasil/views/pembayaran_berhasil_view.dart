// pembayaran_berhasil_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pembayaran_berhasil_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class PembayaranBerhasilView extends GetView<PembayaranBerhasilController> {
  const PembayaranBerhasilView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // PEMBAYARAN BERHASIL
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Padding(
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
                        "Status Pembayaran",

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

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      SizedBox(height: size.height * 0.04),

                      // ICON SUCCESS
                      Stack(
                        alignment: Alignment.center,

                        children: [
                          Container(
                            width: size.width * 0.55,

                            height: size.width * 0.55,

                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.08),

                              shape: BoxShape.circle,
                            ),
                          ),

                          Container(
                            width: size.width * 0.38,

                            height: size.width * 0.38,

                            decoration: const BoxDecoration(
                              color: Colors.green,

                              shape: BoxShape.circle,
                            ),

                            child: Icon(
                              Icons.check,

                              size: size.width * 0.18,

                              color: Colors.white,
                            ),
                          ),

                          Positioned(
                            top: 10,
                            left: 20,

                            child: confetti(Colors.orange),
                          ),

                          Positioned(
                            top: 60,
                            right: 20,

                            child: confetti(Colors.green),
                          ),

                          Positioned(
                            bottom: 30,

                            left: 10,

                            child: confetti(Colors.blue),
                          ),

                          Positioned(
                            bottom: 20,

                            right: 30,

                            child: confetti(Colors.amber),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.05),

                      // TITLE
                      Obx(
                        () => Text(
                          controller.judul.value,

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontSize: size.width * 0.08,

                            fontWeight: FontWeight.bold,

                            color: Colors.green,
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.025),

                      // SUBTITLE
                      Obx(
                        () => Text(
                          controller.subtitle.value,

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontSize: size.width * 0.042,

                            color: Colors.black87,

                            height: 1.7,
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      // ORDER ID
                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: Column(
                          children: [
                            const Icon(
                              Icons.receipt_long_outlined,

                              size: 38,

                              color: Color(0xFF5A3116),
                            ),

                            const SizedBox(height: 14),

                            const Text(
                              "Order ID",

                              style: TextStyle(
                                fontSize: 18,

                                color: Colors.brown,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Obx(
                              () => Text(
                                controller.orderId.value,

                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  fontSize: size.width * 0.048,

                                  fontWeight: FontWeight.bold,

                                  color: const Color(0xFF3E2723),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.05),

                      // BUTTON LANJUT
                      Obx(
                        () => SizedBox(
                          width: double.infinity,

                          height: 65,

                          child: ElevatedButton(
                            onPressed: controller.lanjut,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5A3116),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),

                            child: Text(
                              controller.buttonText.value,

                              style: TextStyle(
                                fontSize: size.width * 0.045,

                                fontWeight: FontWeight.bold,

                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      // BUTTON BERANDA
                      SizedBox(
                        width: double.infinity,

                        height: 65,

                        child: OutlinedButton(
                          onPressed: controller.kembaliKeBeranda,

                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF5A3116)),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),

                          child: Text(
                            "Kembali ke Beranda",

                            style: TextStyle(
                              fontSize: size.width * 0.043,

                              fontWeight: FontWeight.bold,

                              color: const Color(0xFF5A3116),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget confetti(Color color) {
    return Container(
      width: 16,
      height: 16,

      decoration: BoxDecoration(
        color: color,

        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
