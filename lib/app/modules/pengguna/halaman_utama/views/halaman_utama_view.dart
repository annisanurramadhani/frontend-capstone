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

      // HALAMAN UTAMA
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.055),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),

              // TITLE
              Text(
                "Halaman Utama",
                style: TextStyle(
                  fontSize: size.width * 0.085,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 10),

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
                  borderRadius: BorderRadius.circular(28),

                  image: const DecorationImage(
                    image: AssetImage("assets/images/banner_anyaman.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),

                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),

                    borderRadius: BorderRadius.circular(22),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
              ),

              SizedBox(height: size.height * 0.04),

              Text(
                "Menu",
                style: TextStyle(
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3E2723),
                ),
              ),

              SizedBox(height: size.height * 0.025),

              // MENU GRID
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
                          childAspectRatio: 1,
                        ),

                    itemBuilder: (context, index) {
                      final data = controller.menuUtama[index];

                      return GestureDetector(
                        onTap: () {
                          controller.pindahHalaman(data["route"]);
                        },

                        child: Container(
                          padding: const EdgeInsets.all(20),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(28),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Image.asset(data["icon"], width: 60, height: 60),

                              const SizedBox(height: 18),

                              Text(
                                data["title"],

                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  fontSize: size.width * 0.042,

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
