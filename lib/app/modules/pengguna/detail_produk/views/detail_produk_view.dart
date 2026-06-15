import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_produk_controller.dart';

class DetailProdukView extends GetView<DetailProdukController> {
  const DetailProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final produk = controller.produk;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "http://192.168.110.206:3000/uploads/${produk["foto"]}",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
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
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(
                            '/checkout',
                            arguments: {'produkId': produk['id'], 'qty': 1},
                          );
                        },
                        child: const Text("Beli Sekarang"),
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
