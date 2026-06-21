import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_produk_controller.dart';

class DetailProdukView extends GetView<DetailProdukController> {
  const DetailProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5F1),
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF3E2723),
            size: 20,
          ),
        ),

        title: const Text(
          "Detail Produk",
          style: TextStyle(
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/keranjang');
            },
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
          return const Center(child: CircularProgressIndicator());
        }

        final produk = controller.produk;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  "http://10.223.117.75:3000/uploads/${produk["foto"]}",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produk["namaProduk"] ?? "",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Rp ${produk["harga"]}",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text("Kategori : ${produk["kategori"]}"),

                    const SizedBox(height: 10),

                    Text("Ukuran : ${produk["ukuran"] ?? "-"}"),

                    const SizedBox(height: 10),

                    Text("Bahan : ${produk["bahan"] ?? "-"}"),

                    const SizedBox(height: 10),

                    Text("Stok : ${produk["stok"]}"),

                    const SizedBox(height: 20),

                    const Text(
                      "Deskripsi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(produk["deskripsi"] ?? ""),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(
                            '/checkout',
                            arguments: {'produkId': produk['id'], 'qty': 1},
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5A3116),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Beli Sekarang",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
