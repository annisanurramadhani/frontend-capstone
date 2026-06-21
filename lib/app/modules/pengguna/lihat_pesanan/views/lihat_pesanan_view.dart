import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lihat_pesanan_controller.dart';

class LihatPesananView extends GetView<LihatPesananController> {
  const LihatPesananView({super.key});

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
          "Riwayat Pembelian",
          style: TextStyle(
            color: Color(0xFF5A3116),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.pesananList.isEmpty) {
          return const Center(child: Text("Belum ada pesanan"));
        }

        return ListView.builder(
          itemCount: controller.pesananList.length,

          itemBuilder: (context, index) {
            final pesanan = controller.pesananList[index];

            return Card(
              margin: const EdgeInsets.all(10),

              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      pesanan["orderId"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 5),

                    Text("Status Bayar : ${pesanan["statusBayar"]}"),

                    Text("Status Pesanan : ${pesanan["statusPesanan"]}"),

                    Text("Total : Rp ${pesanan["totalBayar"]}"),

                    const Divider(),

                    ...List.generate(pesanan["detailPesanan"].length, (i) {
                      final item = pesanan["detailPesanan"][i];

                      return ListTile(
                        contentPadding: EdgeInsets.zero,

                        title: Text(item["produk"]["namaProduk"]),

                        subtitle: Text("Qty ${item["qty"]}"),

                        trailing: Text("Rp ${item["subtotal"]}"),
                      );
                    }),
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
