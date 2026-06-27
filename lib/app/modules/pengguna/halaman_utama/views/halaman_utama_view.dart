import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_navbar.dart';
import '../controllers/halaman_utama_controller.dart';
import '../../../../data/providers/api_provider.dart';

class HalamanUtamaView extends StatefulWidget {
  const HalamanUtamaView({super.key});

  @override
  State<HalamanUtamaView> createState() => _HalamanUtamaViewState();
}

class _HalamanUtamaViewState extends State<HalamanUtamaView> {
  final controller = Get.find<HalamanUtamaController>();

  final PageController pageController = PageController();

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    autoSlide();
  }

  void autoSlide() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 3));

      currentPage++;

      if (currentPage > 2) {
        currentPage = 0;
      }

      if (mounted) {
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 11) {
      return "Selamat Pagi!";
    } else if (hour < 15) {
      return "Selamat Siang!";
    } else if (hour < 18) {
      return "Selamat Sore!";
    } else {
      return "Selamat Malam!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),
      bottomNavigationBar: const CustomNavbar(currentIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.02, w * 0.05, h * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Row(
                  children: [
                    CircleAvatar(
                      radius: w * 0.075,
                      backgroundColor: const Color(0xFFF2E7DB),
                      backgroundImage:
                          controller.user["photo"] != null &&
                              controller.user["photo"].toString().isNotEmpty
                          ? NetworkImage(
                              "${ApiProvider.baseUrl}${controller.user["photo"]}",
                            )
                          : null,
                      child:
                          controller.user["photo"] == null ||
                              controller.user["photo"].toString().isEmpty
                          ? Icon(
                              Icons.person,
                              color: Color(0xFF5A3116),
                              size: w * 0.075,
                            )
                          : null,
                    ),

                    SizedBox(width: w * 0.035),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting,
                            style: TextStyle(
                              fontSize: w * 0.040,
                              color: Color(0xFF8B6347),
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            controller.nama.value.isEmpty
                                ? "Pengguna"
                                : controller.nama.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2723),
                            ),
                          ),

                          const SizedBox(height: 3),
                        ],
                      ),
                    ),

                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Get.toNamed("/notifikasi");
                      },
                      child: Container(
                        width: w * 0.13,
                        height: w * 0.13,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.withOpacity(.08),
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: Color(0xFF5A3116),
                          size: w * 0.065,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.035), // BANNER
              SizedBox(
                height: h * 0.24,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(w * 0.06),
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        children: [
                          Image.asset(
                            "assets/image/banner1.jpg",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "assets/image/banner2.png",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "assets/image/banner3.png",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.45),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    const Positioned(
                      left: 22,
                      bottom: 22,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? w * 0.055 : w * 0.02,

                    height: w * 0.02,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? const Color(0xFF5A3116)
                          : Colors.brown.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Apa yang ingin Anda lakukan?",
                style: TextStyle(
                  fontSize: w * 0.043,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 18),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(
                        color: Color(0xFF5A3116),
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    _FeatureCard(
                      icon: Icons.menu_book_rounded,
                      title: "Belajar Anyaman",
                      subtitle: "Pelajari berbagai teknik dasar anyaman bambu.",
                      onTap: () {
                        controller.pindahHalaman(
                          controller.menuUtama[0]["route"],
                        );
                      },
                    ),

                    SizedBox(height: h * 0.02),
                    _FeatureCard(
                      icon: Icons.groups_rounded,
                      title: "Daftar Pengrajin",
                      subtitle: "Temukan pengrajin lokal dan mentor terbaik.",
                      onTap: () {
                        controller.pindahHalaman(
                          controller.menuUtama[1]["route"],
                        );
                      },
                    ),

                    SizedBox(height: h * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: _SmallFeatureCard(
                            icon: Icons.shopping_bag_outlined,
                            title: "Produk\nAnyaman",
                            onTap: () {
                              controller.pindahHalaman(
                                controller.menuUtama[2]["route"],
                              );
                            },
                          ),
                        ),

                        SizedBox(height: h * 0.02),
                        Expanded(
                          child: _SmallFeatureCard(
                            icon: Icons.workspace_premium_outlined,
                            title: "Sertifikat",
                            onTap: () {
                              controller.pindahHalaman(
                                controller.menuUtama[3]["route"],
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.035),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5ECE3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: const Color(0xFF5A3116), size: 30),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Color(0xFF5A3116),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SmallFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SmallFeatureCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(.08),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.21,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5ECE3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: const Color(0xFF5A3116), size: 28),
                ),

                SizedBox(height: 20),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
