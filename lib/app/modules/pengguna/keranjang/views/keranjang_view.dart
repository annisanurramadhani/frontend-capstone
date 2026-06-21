import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF5A3116),
            size: 20,
          ),
        ),

        title: const Text(
          "Keranjang",
          style: TextStyle(
            color: Color(0xFF5A3116),
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/lihat-pesanan");
            },
            icon: const Icon(Icons.receipt_long, color: Color(0xFF5A3116)),
            tooltip: "Riwayat Pembelian",
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
                            "http://10.223.117.75:3000/uploads/${produk["foto"]}",

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

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/checkout");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5E3C),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Checkout",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
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
