// belajar_anyaman_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/belajar_anyaman_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class BelajarAnyamanView extends GetView<BelajarAnyamanController> {
  const BelajarAnyamanView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(size.width * 0.055),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: controller.kembali,
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF5A3116),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.01),

              Center(
                child: Column(
                  children: [
                    Text(
                      "Belajar Anyaman",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.085,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3E2723),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Pelajari teknik anyaman dari dasar hingga mahir.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.043,
                        color: Colors.brown,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.05),

              Text(
                "Materi",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3E2723),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              materiCard(
                nomor: "1",
                title: "Pengenalan Anyaman",
                subtitle: "Mengenal alat, bahan, dan dasar anyaman bambu.",
                durasi: "15 Menit",
                image: "assets/images/materi1.jpg",
              ),

              const SizedBox(height: 20),

              materiCard(
                nomor: "2",
                title: "Teknik Dasar Anyaman",
                subtitle: "Belajar teknik dasar seperti silang dan lilit.",
                durasi: "25 Menit",
                image: "assets/images/materi2.jpg",
              ),

              const SizedBox(height: 20),

              materiCard(
                nomor: "3",
                title: "Pola Anyaman",
                subtitle: "Belajar membuat pola anyaman lebih kompleks.",
                durasi: "40 Menit",
                image: "assets/images/materi3.jpg",
              ),

              const SizedBox(height: 20),

              materiCard(
                nomor: "4",
                title: "Finishing & Perawatan",
                subtitle: "Teknik finishing agar produk lebih awet.",
                durasi: "20 Menit",
                image: "assets/images/materi4.jpg",
              ),

              SizedBox(height: size.height * 0.04),

              // Tips
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3EAE0),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline,
                        size: 34,
                        color: Color(0xFF5A3116),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tips Belajar",
                            style: TextStyle(
                              fontSize: size.width * 0.055,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3E2723),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Pelajari materi secara berurutan agar lebih mudah dipahami.",
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.brown,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.06),
            ],
          ),
        ),
      ),
    );
  }

  Widget materiCard({
    required String nomor,
    required String title,
    required String subtitle,
    required String durasi,
    required String image,
  }) {
    return InkWell(
      onTap: controller.keMateriAnyaman,
      borderRadius: BorderRadius.circular(24),
      child: Container(
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
                image,
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
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3EAE0),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            nomor,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5A3116),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.brown,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 20,
                        color: Colors.brown,
                      ),

                      const SizedBox(width: 8),

                      Text(durasi, style: const TextStyle(color: Colors.brown)),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF5A3116),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
