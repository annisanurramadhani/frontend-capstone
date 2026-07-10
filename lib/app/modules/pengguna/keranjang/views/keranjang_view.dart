import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../global_widgets/custom_navbar.dart';
import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),

      bottomNavigationBar: const CustomNavbar(currentIndex: -1),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF5A3116)),
            );
          }

          return Column(
            children: [
              SizedBox(height: h * 0.02),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: SizedBox(
                  height: h * 0.065,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: w * 0.055,
                            color: const Color(0xFF5A3116),
                          ),
                        ),
                      ),

                      Text(
                        "Keranjang",
                        style: TextStyle(
                          fontSize: w * 0.065,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3E2723),
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
                    "Produk yang akan Anda beli",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w * 0.034,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: controller.keranjangList.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 70,
                              color: Color(0xFFD7C4B0),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Keranjang kosong",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF8B6347),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                        itemCount: controller.keranjangList.length,
                        itemBuilder: (context, index) {
                          final item = controller.keranjangList[index];

                          final produk = item["produk"];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: EdgeInsets.all(w * 0.035),
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    produk["foto"].toString().startsWith("http")
                                        ? produk["foto"]
                                        : "${ApiProvider.baseUrl}${produk["foto"]}",
                                    width: w * 0.22,
                                    height: w * 0.22,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) {
                                        return child;
                                      }

                                      return Container(
                                        width: 90,
                                        height: 90,
                                        color: const Color(0xFFF3EAE0),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Color(0xFF5A3116),
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 90,
                                      height: 90,
                                      color: const Color(0xFFF3EAE0),
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Color(0xFF5A3116),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: w * 0.035),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  produk["namaProduk"] ?? "",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: w * 0.038,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF3E2723),
                                                  ),
                                                ),

                                                const SizedBox(height: 3),

                                                Text(
                                                  produk["kategori"] ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),

                                                const SizedBox(height: 10),

                                                Text(
                                                  "Rp ${produk["harga"]}",
                                                  style: TextStyle(
                                                    fontSize: w * 0.040,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF5A3116),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          InkWell(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            onTap: () {
                                              Get.dialog(
                                                Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          24,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          24,
                                                        ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .delete_outline_rounded,
                                                          size: 60,
                                                          color: Colors.red,
                                                        ),

                                                        const SizedBox(
                                                          height: 16,
                                                        ),

                                                        const Text(
                                                          "Hapus Produk?",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          height: 10,
                                                        ),

                                                        const Text(
                                                          "Produk akan dihapus dari keranjang.",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        const SizedBox(
                                                          height: 24,
                                                        ),

                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: OutlinedButton(
                                                                onPressed: () =>
                                                                    Get.back(),
                                                                style: OutlinedButton.styleFrom(
                                                                  side: const BorderSide(
                                                                    color: Color(
                                                                      0xFF5A3116,
                                                                    ),
                                                                  ),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          12,
                                                                        ),
                                                                  ),
                                                                ),
                                                                child: const Text(
                                                                  "Batal",
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                      0xFF5A3116,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            const SizedBox(
                                                              width: 12,
                                                            ),

                                                            Expanded(
                                                              child: ElevatedButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                  controller
                                                                      .hapusKeranjang(
                                                                        item["id"],
                                                                      );
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  elevation: 0,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          12,
                                                                        ),
                                                                  ),
                                                                ),
                                                                child: const Text(
                                                                  "Hapus",
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
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
                                              );
                                            },
                                            child: const Icon(
                                              Icons.delete_outline_rounded,
                                              color: Colors.red,
                                              size: 22,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 14),

                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () => controller.kurangQty(
                                              item["id"],
                                              item["qty"],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Container(
                                              width: w * 0.085,
                                              height: w * 0.085,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF3EAE0),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                size: 18,
                                                color: Color(0xFF5A3116),
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 14,
                                            ),
                                            child: Text(
                                              "${item["qty"]}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          InkWell(
                                            onTap: () => controller.tambahQty(
                                              item["id"],
                                              item["qty"],
                                              produk["stok"],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Container(
                                              width: 34,
                                              height: 34,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF5A3116),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),

                                          const Spacer(),

                                          Text(
                                            "Rp ${produk["harga"] * item["qty"]}",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF5A3116),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(
                  w * 0.05,
                  h * 0.02,
                  w * 0.05,
                  h * 0.03,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF8B6347),
                                ),
                              ),

                              const SizedBox(height: 2),

                              Obx(
                                () => Text(
                                  "Rp ${controller.totalHarga.value}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3E2723),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: h * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed("/checkout");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5A3116),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                horizontal: w * 0.06,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              "Pesan Sekarang",
                              style: TextStyle(
                                fontSize: w * 0.037,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}