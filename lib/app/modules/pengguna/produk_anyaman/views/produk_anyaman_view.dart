import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/services/pengguna_service.dart';
import '../controllers/produk_anyaman_controller.dart';

class ProdukAnyamanView extends GetView<ProdukAnyamanController> {
  const ProdukAnyamanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Anyaman"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/keranjang');
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.produkList.isEmpty) {
          return const Center(child: Text("Belum ada produk"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.produkList.length,
          itemBuilder: (context, index) {
            final produk = controller.produkList[index];

            return GestureDetector(
              onTap: () {
                Get.toNamed('/detail-produk', arguments: produk["id"]);
              },

              child: Card(
                margin: const EdgeInsets.only(bottom: 16),

                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),

                        child: Image.network(
                          "http://192.168.110.206:3000/uploads/${produk["foto"]}",
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image, size: 90),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              produk["namaProduk"] ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(produk["kategori"] ?? ""),

                            const SizedBox(height: 6),

                            Text(
                              "Rp ${produk["harga"]}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text("Stok : ${produk["stok"]}"),
                            const SizedBox(height: 10),

                            SizedBox(
                              width: double.infinity,
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
                                            );
                                          } else {
                                            Get.snackbar(
                                              "Gagal",
                                              response["message"] ??
                                                  "Terjadi kesalahan",
                                            );
                                          }
                                        } catch (e) {
                                          Get.snackbar("Error", e.toString());
                                        }
                                      },
                                icon: Icon(
                                  (produk["stok"] ?? 0) <= 0
                                      ? Icons.remove_shopping_cart
                                      : Icons.shopping_cart_outlined,
                                  size: 18,
                                ),
                                label: Text(
                                  (produk["stok"] ?? 0) <= 0
                                      ? "Stok Habis"
                                      : "Tambah Keranjang",
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
