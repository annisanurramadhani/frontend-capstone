// notifikasi_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notifikasi_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // NOTIFIKASI
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Obx(() {
          if (controller.notifikasi.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.notifications_none,

                    size: size.width * 0.22,

                    color: Colors.brown.shade300,
                  ),

                  SizedBox(height: size.height * 0.02),

                  Text(
                    "Belum Ada Notifikasi",

                    style: TextStyle(
                      fontSize: size.width * 0.055,

                      fontWeight: FontWeight.bold,

                      color: const Color(0xFF3E2723),
                    ),
                  ),

                  SizedBox(height: size.height * 0.01),

                  Text(
                    "Notifikasi pembayaran dan jadwal akan muncul di sini",

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: size.width * 0.04,

                      color: Colors.brown,

                      height: 1.6,
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: EdgeInsets.all(size.width * 0.055),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Notifikasi",

                  style: TextStyle(
                    fontSize: size.width * 0.085,

                    fontWeight: FontWeight.bold,

                    color: const Color(0xFF3E2723),
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                Text(
                  "Informasi terbaru kelas dan pembayaran",

                  style: TextStyle(
                    fontSize: size.width * 0.042,

                    color: Colors.brown,
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                ListView.builder(
                  itemCount: controller.notifikasi.length,

                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemBuilder: (context, index) {
                    final item = controller.notifikasi[index];

                    return GestureDetector(
                      onTap: () {
                        controller.bukaNotifikasi(item);
                      },

                      child: Container(
                        margin: EdgeInsets.only(bottom: size.height * 0.02),

                        padding: EdgeInsets.all(size.width * 0.045),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(
                              width: 60,

                              height: 60,

                              decoration: BoxDecoration(
                                color: item["tipe"] == "pembayaran"
                                    ? Colors.green.withOpacity(0.12)
                                    : Colors.orange.withOpacity(0.12),

                                shape: BoxShape.circle,
                              ),

                              child: Icon(
                                item["tipe"] == "pembayaran"
                                    ? Icons.check_circle_outline
                                    : Icons.calendar_month_outlined,

                                color: item["tipe"] == "pembayaran"
                                    ? Colors.green
                                    : Colors.orange,

                                size: 30,
                              ),
                            ),

                            SizedBox(width: size.width * 0.04),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    item["judul"] ?? "",

                                    style: TextStyle(
                                      fontSize: size.width * 0.048,

                                      fontWeight: FontWeight.bold,

                                      color: const Color(0xFF3E2723),
                                    ),
                                  ),

                                  SizedBox(height: size.height * 0.01),

                                  Text(
                                    item["pesan"] ?? "",

                                    style: TextStyle(
                                      fontSize: size.width * 0.04,

                                      color: Colors.black87,

                                      height: 1.6,
                                    ),
                                  ),

                                  SizedBox(height: size.height * 0.012),

                                  Text(
                                    item["waktu"] ?? "",

                                    style: TextStyle(
                                      fontSize: size.width * 0.035,

                                      color: Colors.grey,
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
              ],
            ),
          );
        }),
      ),
    );
  }
}
