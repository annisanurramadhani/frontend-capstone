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

    final List<String> banners = [
      "assets/image/banner.jpg",
      "assets/image/banner2.jpg",
      "assets/image/banner3.jpg",
    ];

    final PageController pageController = PageController(
      viewportFraction: 0.95,
    );

    final RxInt currentBanner = 0.obs;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: RefreshIndicator(
          color: const Color(0xFF8B5E3C),

          onRefresh: () async {
            controller.getUser();
          },

          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.055,

              vertical: 20,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // HEADER
                Obx(
                  () => Row(
                    children: [
                      Container(
                        width: 60,

                        height: 60,

                        decoration: const BoxDecoration(
                          color: Color(0xFFF3EAE0),

                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.person,

                          size: 30,

                          color: Color(0xFF5A3116),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Selamat Datang!",

                              style: TextStyle(
                                fontSize: size.width * 0.038,

                                color: Colors.brown,
                              ),
                            ),

                            const SizedBox(height: 2),

                            Text(
                              controller.nama.value.isEmpty
                                  ? "Pengguna"
                                  : controller.nama.value,

                              maxLines: 1,

                              overflow: TextOverflow.ellipsis,

                              style: TextStyle(
                                fontSize: size.width * 0.05,

                                fontWeight: FontWeight.bold,

                                color: const Color(0xFF3E2723),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 48,

                        height: 48,

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(16),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),

                              blurRadius: 8,

                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),

                        child: IconButton(
                          onPressed: () {
                            Get.toNamed('/notifikasi');
                          },

                          icon: const Icon(
                            Icons.notifications_none_rounded,

                            color: Color(0xFF5A3116),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.035),

                // SLIDER BANNER
                Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.22,

                      child: PageView.builder(
                        controller: pageController,

                        onPageChanged: (index) {
                          currentBanner.value = index;
                        },

                        itemCount: banners.length,

                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 12),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),

                              image: DecorationImage(
                                image: AssetImage(banners[index]),

                                fit: BoxFit.cover,
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),

                                  blurRadius: 12,

                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 14),

                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: List.generate(
                          banners.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),

                            margin: const EdgeInsets.symmetric(horizontal: 4),

                            width: currentBanner.value == index ? 22 : 8,

                            height: 8,

                            decoration: BoxDecoration(
                              color: currentBanner.value == index
                                  ? const Color(0xFF8B5E3C)
                                  : Colors.brown.shade200,

                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.04),

                // MENU TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      "Menu Utama",

                      style: TextStyle(
                        fontSize: size.width * 0.06,

                        fontWeight: FontWeight.bold,

                        color: const Color(0xFF3E2723),
                      ),
                    ),

                    Text(
                      "${controller.menuUtama.length} Menu",

                      style: TextStyle(
                        fontSize: size.width * 0.035,

                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.025),

                // GRID MENU
                Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
                      height: size.height * 0.4,

                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: controller.menuUtama.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,

                      crossAxisSpacing: size.width * 0.04,

                      mainAxisSpacing: size.width * 0.04,

                      childAspectRatio: 1,
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

                            borderRadius: BorderRadius.circular(30),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),

                                blurRadius: 10,

                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Container(
                                width: 70,

                                height: 70,

                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8F2EC),

                                  borderRadius: BorderRadius.circular(22),
                                ),

                                child: Icon(
                                  data["icon"],

                                  size: 36,

                                  color: const Color(0xFF5A3116),
                                ),
                              ),

                              const SizedBox(height: 18),

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

                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
