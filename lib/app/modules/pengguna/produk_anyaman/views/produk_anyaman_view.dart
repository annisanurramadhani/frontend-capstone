import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../data/services/pengguna_service.dart';
import '../../../../global_widgets/custom_navbar.dart';
import '../controllers/produk_anyaman_controller.dart';

class ProdukAnyamanView extends GetView<ProdukAnyamanController> {
  const ProdukAnyamanView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),

      bottomNavigationBar: const CustomNavbar(currentIndex: -1),

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: h * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: SizedBox(
                height: 56,
                child: Row(
                  children: [
                    SizedBox(
                      width: 48,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 22,
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: w * 0.055,
                          color: const Color(0xFF5A3116),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "Produk Anyaman",
                          style: TextStyle(
                            fontSize: w * 0.065,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 48,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed('/keranjang');
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 22,
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          size: w * 0.055,
                          color: const Color(0xFF5A3116),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.004),

            Center(
              child: SizedBox(
                width: w * 0.82,
                child: Text(
                  "Temukan berbagai hasil kerajinan anyaman bambu",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: w * 0.034,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ),
            ),

            SizedBox(height: h * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: TextField(
                onChanged: controller.searchProduk,
                decoration: InputDecoration(
                  hintText: "Cari produk...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: h * 0.018),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF5A3116)),
                  );
                }

                if (controller.produkList.isEmpty) {
                  return const Center(
                    child: Text(
                      "Belum ada produk",
                      style: TextStyle(color: Colors.brown, fontSize: 15),
                    ),
                  );
                }

                return GridView.builder(
                  padding: EdgeInsets.fromLTRB(w * 0.04, 4, w * 0.04, h * 0.03),
                  itemCount: controller.produkList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.58,
                  ),
                  itemBuilder: (context, index) {
                    final produk = controller.produkList[index];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          Get.toNamed(
                            '/detail-produk',
                            arguments: produk["id"],
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(18),
                                    ),
                                    child: Image.network(
                                      "${ApiProvider.baseUrl}${produk["foto"]}",
                                      width: double.infinity,
                                      height: h * 0.18,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, progress) {
                                            if (progress == null) return child;

                                            return Container(
                                              height: h * 0.18,
                                              color: const Color(0xFFF3EAE0),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Color(0xFF5A3116),
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                            );
                                          },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          height: 145,
                                          color: const Color(0xFFF3EAE0),
                                          child: const Center(
                                            child: Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              size: 40,
                                              color: Color(0xFF5A3116),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  if ((produk["stok"] ?? 0) <= 0)
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Text(
                                          "HABIS",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(w * 0.025),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        produk["namaProduk"] ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: w * 0.035,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF3E2723),
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        produk["kategori"] ?? "",
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      const Spacer(),
                                      Text(
                                        "Rp ${produk["harga"]}",
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF5A3116),
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Stok ${produk["stok"]}",
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),

                                          SizedBox(
                                            width: w * 0.09,
                                            height: w * 0.09,
                                            child: Material(
                                              color: (produk["stok"] ?? 0) <= 0
                                                  ? Colors.grey.shade300
                                                  : const Color(0xFF5A3116),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                onTap:
                                                    (produk["stok"] ?? 0) <= 0
                                                    ? null
                                                    : () async {
                                                        try {
                                                          final response =
                                                              await PenggunaService.createKeranjang(
                                                                produkId:
                                                                    produk["id"],
                                                                qty: 1,
                                                              );

                                                          if (response["success"] ==
                                                              true) {
                                                            Get.snackbar(
                                                              "Berhasil",
                                                              "Produk ditambahkan ke keranjang",
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .TOP,
                                                              backgroundColor:
                                                                  Colors.green,
                                                              colorText:
                                                                  Colors.white,
                                                            );
                                                          } else {
                                                            Get.snackbar(
                                                              "Gagal",
                                                              response["message"] ??
                                                                  "Terjadi kesalahan",
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .TOP,
                                                            );
                                                          }
                                                        } catch (e) {
                                                          Get.snackbar(
                                                            "Error",
                                                            e.toString(),
                                                            snackPosition:
                                                                SnackPosition
                                                                    .TOP,
                                                          );
                                                        }
                                                      },
                                                child: Icon(
                                                  (produk["stok"] ?? 0) <= 0
                                                      ? Icons
                                                            .remove_shopping_cart_outlined
                                                      : Icons
                                                            .shopping_cart_outlined,
                                                  color: Colors.white,
                                                  size: w * 0.045,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
