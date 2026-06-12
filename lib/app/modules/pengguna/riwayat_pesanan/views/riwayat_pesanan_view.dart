import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/riwayat_pesanan_controller.dart';

class RiwayatPesananView extends GetView<RiwayatPesananController> {
  const RiwayatPesananView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      appBar: AppBar(
        title: const Text("Riwayat Pesanan"),

        centerTitle: true,

        elevation: 0,

        backgroundColor: const Color(0xFFFDF8F3),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.riwayatPesanan.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 80,
                  color: Colors.grey,
                ),

                SizedBox(height: 15),

                Text(
                  "Belum ada riwayat pesanan",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,

          child: ListView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: controller.riwayatPesanan.length,

            itemBuilder: (context, index) {
              final pesanan =
                  controller.riwayatPesanan[index];

              return Container(
                margin: const EdgeInsets.only(
                  bottom: 15,
                ),

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      pesanan["namaProduk"] ?? "-",

                      style: const TextStyle(
                        fontSize: 16,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Tanggal : ${pesanan["tanggal"] ?? "-"}",
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "Total : Rp ${pesanan["total"] ?? 0}",
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,

                        borderRadius:
                            BorderRadius.circular(20),
                      ),

                      child: Text(
                        pesanan["status"] ?? "-",

                        style: TextStyle(
                          color:
                              Colors.orange.shade800,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}