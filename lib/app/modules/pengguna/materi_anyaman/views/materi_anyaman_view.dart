// materi_anyaman_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/materi_anyaman_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class MateriAnyamanView extends GetView<MateriAnyamanController> {
  const MateriAnyamanView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // MATERI ANYAMAN
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.055),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

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
                        "Materi Anyaman",

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

              SizedBox(height: size.height * 0.03),

              // BANNER
              Container(
                width: double.infinity,

                padding: EdgeInsets.all(size.width * 0.06),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),

                  image: const DecorationImage(
                    image: AssetImage("assets/images/banner_materi.jpg"),

                    fit: BoxFit.cover,
                  ),
                ),

                child: Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),

                    borderRadius: BorderRadius.circular(22),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Belajar Teknik Anyaman",

                        style: TextStyle(
                          fontSize: size.width * 0.055,

                          fontWeight: FontWeight.bold,

                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Pelajari teknik dasar hingga mahir bersama pengrajin lokal.",

                        style: TextStyle(
                          fontSize: size.width * 0.038,

                          color: Colors.white,

                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.04),

              // TITLE
              Text(
                "Daftar Materi",

                style: TextStyle(
                  fontSize: size.width * 0.06,

                  fontWeight: FontWeight.bold,

                  color: const Color(0xFF3E2723),
                ),
              ),

              SizedBox(height: size.height * 0.025),

              // LIST
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.materiList.isEmpty) {
                    return const Center(child: Text("Materi belum tersedia"));
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),

                    itemCount: controller.materiList.length,

                    itemBuilder: (context, index) {
                      final data = controller.materiList[index];

                      return GestureDetector(
                        onTap: () {
                          controller.detailMateri(data);
                        },

                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),

                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(26),
                          ),

                          child: Row(
                            children: [
                              // IMAGE
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),

                                child: Image.asset(
                                  data["thumbnail"],

                                  width: 100,
                                  height: 100,

                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 18),

                              // CONTENT
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      data["title"],

                                      style: TextStyle(
                                        fontSize: size.width * 0.047,

                                        fontWeight: FontWeight.bold,

                                        color: const Color(0xFF3E2723),
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time_rounded,

                                          size: 20,

                                          color: Colors.brown,
                                        ),

                                        const SizedBox(width: 8),

                                        Text(
                                          data["durasi"],

                                          style: TextStyle(
                                            fontSize: size.width * 0.038,

                                            color: Colors.brown,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const Icon(
                                Icons.arrow_forward_ios,

                                size: 18,

                                color: Color(0xFF5A3116),
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
