import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              Get.toNamed("/lihat-pesanan");
            },
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.keranjangList.isEmpty) {
          return const Center(child: Text("Keranjang kosong"));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.keranjangList.length,

                itemBuilder: (context, index) {
                  final item = controller.keranjangList[index];

                  final produk = item["produk"];

                  return Card(
                    margin: const EdgeInsets.all(10),

                    child: Padding(
                      padding: const EdgeInsets.all(10),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Image.network(
                            "http://192.168.18.23:3000/uploads/${produk["foto"]}",

                            width: 80,

                            height: 80,

                            fit: BoxFit.cover,

                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image, size: 80),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  produk["namaProduk"],

                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,

                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "Rp ${produk["harga"]}",

                                  style: const TextStyle(
                                    color: Colors.green,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.kurangQty(
                                          item["id"],
                                          item["qty"],
                                        );
                                      },

                                      icon: const Icon(
                                        Icons.remove_circle_outline,

                                        color: Colors.red,
                                      ),
                                    ),

                                    Text(
                                      "${item["qty"]}",

                                      style: const TextStyle(
                                        fontSize: 16,

                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        controller.tambahQty(
                                          item["id"],
                                          item["qty"],
                                          produk["stok"],
                                        );
                                      },

                                      icon: const Icon(
                                        Icons.add_circle_outline,

                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),

                                Text(
                                  "Subtotal : Rp ${produk["harga"] * item["qty"]}",

                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              controller.hapusKeranjang(item["id"]);
                            },

                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: const BoxDecoration(color: Colors.white),

              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => Text(
                        "Total : Rp ${controller.totalHarga.value}",

                        style: const TextStyle(
                          fontSize: 18,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/checkout");
                    },
                    child: const Text("Checkout"),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
