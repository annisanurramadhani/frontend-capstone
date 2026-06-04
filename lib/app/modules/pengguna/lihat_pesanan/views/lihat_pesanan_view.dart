// lihat_pesanan_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lihat_pesanan_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class LihatPesananView extends GetView<LihatPesananController> {
  const LihatPesananView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // LIHAT PESANAN
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
                        "Pesanan Saya",

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

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.pesananList.isEmpty) {
                    return const Center(child: Text("Belum ada pesanan"));
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),

                    itemCount: controller.pesananList.length,

                    itemBuilder: (context, index) {
                      final item = controller.pesananList[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),

                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),

                              child: Image.asset(
                                item["gambar"],

                                width: 100,

                                height: 100,

                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    item["nama"],

                                    style: TextStyle(
                                      fontSize: size.width * 0.05,

                                      fontWeight: FontWeight.bold,

                                      color: const Color(0xFF3E2723),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    item["harga"],

                                    style: const TextStyle(
                                      fontSize: 18,

                                      fontWeight: FontWeight.w600,

                                      color: Color(0xFF5A3116),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,

                                      vertical: 8,
                                    ),

                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9F4EF),

                                      borderRadius: BorderRadius.circular(12),
                                    ),

                                    child: Text(
                                      item["status"],

                                      style: const TextStyle(
                                        color: Color(0xFF5A3116),

                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
}
