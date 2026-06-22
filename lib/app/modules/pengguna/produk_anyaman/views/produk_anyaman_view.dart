import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/services/pengguna_service.dart';
import '../../../../data/providers/api_provider.dart';
import '../controllers/produk_anyaman_controller.dart';

class ProdukAnyamanView extends GetView<ProdukAnyamanController> {
  const ProdukAnyamanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF3E2723),
            size: 20,
          ),
        ),
        title: const Text(
          "Produk Anyaman",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/keranjang'),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xFF3E2723),
              size: 24,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF5A3116)),
          );
        }

        if (controller.produkList.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada produk",
              style: TextStyle(fontSize: 14, color: Colors.brown),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: controller.produkList.length,
          itemBuilder: (context, index) {
            final produk = controller.produkList[index];

            return GestureDetector(
              onTap: () =>
                  Get.toNamed('/detail-produk', arguments: produk["id"]),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // FOTO
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Builder(
                        builder: (context) {
                          final imageUrl =
                              "${ApiProvider.baseUrl}${produk["foto"]}";

                          return Image.network(
                            imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3EAE0),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF5A3116),
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3EAE0),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Color(0xFF5A3116),
                                  size: 36,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            produk["namaProduk"] ?? "",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2723),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            produk["kategori"] ?? "",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF8B6347),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "Rp ${produk["harga"]}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF5A3116),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Row(
                            children: [
                              const Icon(
                                Icons.inventory_2_outlined,
                                size: 13,
                                color: Color(0xFF8B6347),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Stok: ${produk["stok"]}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8B6347),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          SizedBox(
                            width: double.infinity,
                            height: 38,
                            child: ElevatedButton.icon(
                              onPressed: (produk["stok"] ?? 0) <= 0
                                  ? null
                                  : () async {
                                      try {
                                        final response =
                                            await PenggunaService.createKeranjang(
                                          produkId: produk["id"],
                                          qty: 1,
                                        );

                                        if (response["success"] == true) {
                                          Get.snackbar(
                                            "Berhasil",
                                            "Produk ditambahkan ke keranjang",
                                            snackPosition: SnackPosition.TOP,
                                          );
                                        } else {
                                          Get.snackbar(
                                            "Gagal",
                                            response["message"] ??
                                                "Terjadi kesalahan",
                                            snackPosition: SnackPosition.TOP,
                                          );
                                        }
                                      } catch (e) {
                                        Get.snackbar(
                                          "Error",
                                          e.toString(),
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (produk["stok"] ?? 0) <= 0
                                    ? Colors.grey.shade300
                                    : const Color(0xFF5A3116),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: Icon(
                                (produk["stok"] ?? 0) <= 0
                                    ? Icons.remove_shopping_cart_outlined
                                    : Icons.shopping_cart_outlined,
                                size: 15,
                              ),
                              label: Text(
                                (produk["stok"] ?? 0) <= 0
                                    ? "Stok Habis"
                                    : "Tambah Keranjang",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}