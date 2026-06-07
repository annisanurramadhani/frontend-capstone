// halaman_utama_view.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/halaman_utama_controller.dart';

import '../../../../global_widgets/custom_navbar.dart';

class HalamanUtamaView extends GetView<HalamanUtamaController> {
  const HalamanUtamaView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // NAVBAR
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.055),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: size.height * 0.02),

              // HEADER
              Obx(
                () => Row(
                  children: [
                    CircleAvatar(
                      radius: 28,

                      backgroundColor: const Color(0xFFF3EAE0),

                      child: Icon(
                        Icons.person,

                        color: const Color(0xFF5A3116),

                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Selamat Datang 👋",

                            style: TextStyle(
                              fontSize: size.width * 0.04,

                              color: Colors.brown,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            controller.nama.value.isEmpty
                                ? "Pengguna"
                                : controller.nama.value,

                            style: TextStyle(
                              fontSize: size.width * 0.065,

                              fontWeight: FontWeight.bold,

                              color: const Color(0xFF3E2723),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.04),

              // DESKRIPSI
              Text(
                "Belajar dan jelajahi dunia anyaman bambu.",

                style: TextStyle(
                  fontSize: size.width * 0.042,

                  color: Colors.brown,

                  height: 1.6,
                ),
              ),

              SizedBox(height: size.height * 0.04),

              // BANNER
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: const Color(0xFF5A3116),

                  borderRadius: BorderRadius.circular(28),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Icon(Icons.school_outlined, color: Colors.white, size: 40),

                    const SizedBox(height: 16),

                    Text(
                      "Belajar Anyaman Bambu",

                      style: TextStyle(
                        fontSize: size.width * 0.06,

                        fontWeight: FontWeight.bold,

                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Pelajari keterampilan tradisional bersama pengrajin lokal Indonesia.",

                      style: TextStyle(
                        fontSize: size.width * 0.04,

                        color: Colors.white,

                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.04),

              // MENU TITLE
              Text(
                "Menu",

                style: TextStyle(
                  fontSize: size.width * 0.065,

                  fontWeight: FontWeight.bold,

                  color: const Color(0xFF3E2723),
                ),
              ),

              SizedBox(height: size.height * 0.025),

              // GRID MENU
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),

                    itemCount: controller.menuUtama.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,

                          crossAxisSpacing: 18,

                          mainAxisSpacing: 18,

                          childAspectRatio: 0.85,
                        ),

                    itemBuilder: (context, index) {
                      final data = controller.menuUtama[index];

                      return GestureDetector(
                        onTap: () {
                          controller.pindahHalaman(data["route"]);
                        },

                        child: Container(
                          padding: const EdgeInsets.all(18),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(28),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Icon(
                                data["icon"],

                                size: 48,

                                color: const Color(0xFF5A3116),
                              ),

                              const SizedBox(height: 14),

                              Text(
                                data["title"],

                                textAlign: TextAlign.center,

                                maxLines: 2,

                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  fontSize: size.width * 0.038,

                                  fontWeight: FontWeight.bold,

                                  color: const Color(0xFF3E2723),
                                ),
                              ),
                            ],
                          ),
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
