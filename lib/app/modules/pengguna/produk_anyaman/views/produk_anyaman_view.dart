// produk_anyaman_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/produk_anyaman_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class ProdukAnyamanView extends GetView<ProdukAnyamanController> {
  const ProdukAnyamanView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // PRODUK ANYAMAN
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.055),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Produk Anyaman",

                style: TextStyle(
                  fontSize: size.width * 0.085,

                  fontWeight: FontWeight.bold,

                  color: const Color(0xFF3E2723),
                ),
              ),

              SizedBox(height: size.height * 0.01),

              Text(
                "Temukan berbagai produk anyaman berkualitas",

                style: TextStyle(
                  fontSize: size.width * 0.042,

                  color: Colors.black87,

                  height: 1.6,
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // SEARCH
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,

                      padding: const EdgeInsets.symmetric(horizontal: 18),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.brown),

                          SizedBox(width: size.width * 0.03),

                          Text(
                            "Cari produk...",

                            style: TextStyle(
                              fontSize: size.width * 0.04,

                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: size.width * 0.03),

                  Container(
                    width: 60,
                    height: 60,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: const Icon(
                      Icons.filter_alt_outlined,

                      color: Colors.brown,
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.03),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.produkList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(
                            Icons.inventory_2_outlined,

                            size: size.width * 0.2,

                            color: Colors.brown.shade300,
                          ),

                          SizedBox(height: size.height * 0.02),

                          Text(
                            "Produk Belum Tersedia",

                            style: TextStyle(
                              fontSize: size.width * 0.055,

                              fontWeight: FontWeight.bold,

                              color: const Color(0xFF3E2723),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),

                    itemCount: controller.produkList.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,

                      mainAxisSpacing: size.height * 0.025,

                      crossAxisSpacing: size.width * 0.04,

                      childAspectRatio: 0.62,
                    ),

                    itemBuilder: (context, index) {
                      final produk = controller.produkList[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),

                                topRight: Radius.circular(24),
                              ),

                              child: Image.network(
                                produk["gambar"] ?? "",

                                height: size.height * 0.22,

                                width: double.infinity,

                                fit: BoxFit.cover,

                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: size.height * 0.22,

                                    color: Colors.grey.shade200,

                                    child: const Center(
                                      child: Icon(Icons.image_outlined),
                                    ),
                                  );
                                },
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(size.width * 0.04),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      produk["nama"] ?? "",

                                      maxLines: 2,

                                      overflow: TextOverflow.ellipsis,

                                      style: TextStyle(
                                        fontSize: size.width * 0.045,

                                        fontWeight: FontWeight.bold,

                                        color: const Color(0xFF3E2723),
                                      ),
                                    ),

                                    SizedBox(height: size.height * 0.01),

                                    Text(
                                      produk["harga"].toString(),

                                      style: TextStyle(
                                        fontSize: size.width * 0.042,

                                        fontWeight: FontWeight.w600,

                                        color: Colors.brown,
                                      ),
                                    ),

                                    const Spacer(),

                                    SizedBox(
                                      width: double.infinity,

                                      height: 48,

                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.lihatDetail(produk);
                                        },

                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF5A3116,
                                          ),

                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                        ),

                                        child: Text(
                                          "Detail",

                                          style: TextStyle(
                                            fontSize: size.width * 0.038,

                                            fontWeight: FontWeight.bold,

                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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

  Widget bottomNavbar() {
    return Container(
      height: 85,

      decoration: const BoxDecoration(color: Colors.white),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          navbarItem(Icons.history, "Riwayat", false),

          navbarItem(Icons.home, "Home", true),

          navbarItem(Icons.person_outline, "Profil", false),
        ],
      ),
    );
  }

  Widget navbarItem(IconData icon, String title, bool active) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Icon(
          icon,

          size: 30,

          color: active ? const Color(0xFF5A3116) : Colors.grey,
        ),

        const SizedBox(height: 6),

        Text(
          title,

          style: TextStyle(
            fontSize: 15,

            fontWeight: active ? FontWeight.bold : FontWeight.normal,

            color: active ? const Color(0xFF5A3116) : Colors.grey,
          ),
        ),
      ],
    );
  }
}
