import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/halaman_utama_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

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

      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.025),

              // ── HEADER ───────────────────────────────────────────────
              Obx(
                () => Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3EAE0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Color(0xFF5A3116),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selamat Datang!",
                            style: TextStyle(
                              fontSize: 13,
                              color: const Color(0xFF8B6347),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            controller.nama.value.isEmpty
                                ? "Pengguna"
                                : controller.nama.value,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3E2723),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed("/notifikasi"),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3EAE0),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Color(0xFF5A3116),
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // ── BANNER ───────────────────────────────────────────────
              SizedBox(
                height: 190,
                child: PageView(
                  controller: pageController,

                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },

                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(24),
                    //   child: Image.asset(
                    //     "assets/image/banner1.jpg",
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        "assets/image/banner2.png",
                        fit: BoxFit.cover,
                      ),
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        "assets/image/banner3.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? const Color(0xFF5A3116)
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // ── GRID MENU ────────────────────────────────────────────
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(
                        color: Color(0xFF5A3116),
                      ),
                    ),
                  );
                }

                final menu = controller.menuUtama;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menu.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: size.width < 360 ? 0.9 : 1.05,
                  ),
                  itemBuilder: (context, index) {
                    final data = menu[index];
                    return _MenuCard(
                      icon: data["icon"] as IconData,
                      title: data["title"] as String,
                      onTap: () => controller.pindahHalaman(data["route"]),
                    );
                  },
                );
              }),

              SizedBox(height: size.height * 0.025),
            ],
          ),
        ),
      ),
    );
  }
}

// ── MENU CARD WIDGET ─────────────────────────────────────────────────────────

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF0E6DD), width: 1.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFF3EAE0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 28, color: const Color(0xFF5A3116)),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3E2723),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
