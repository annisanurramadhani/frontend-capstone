import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_pesanan_controller.dart';

class DetailPesananView extends GetView<DetailPesananController> {
  const DetailPesananView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      appBar: AppBar(
        title: const Text("Detail Pesanan"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFDF8F3),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Informasi Produk",

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    controller.produk["nama"] ?? "-",

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Rp ${controller.produk["harga"] ?? 0}",

                    style: const TextStyle(
                      color: Color(0xFF5A3116),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Data Penerima",

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  buildItem(
                    "Nama Lengkap",
                    controller.nama,
                  ),

                  buildItem(
                    "Nomor Telepon",
                    controller.noTelpon,
                  ),

                  buildItem(
                    "Kecamatan",
                    controller.kecamatan,
                  ),

                  buildItem(
                    "Alamat",
                    controller.alamat,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  buildPrice(
                    "Harga Produk",
                    controller.produk["harga"] ?? 0,
                  ),

                  const SizedBox(height: 12),

                  buildPrice(
                    "Ongkir",
                    controller.ongkir,
                  ),

                  const Divider(height: 25),

                  buildPrice(
                    "Total Pembayaran",
                    controller.total,
                    bold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),

              decoration: BoxDecoration(
                color: Colors.orange.shade100,

                borderRadius: BorderRadius.circular(16),
              ),

              child: const Center(
                child: Text(
                  "Menunggu Pembayaran",

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,

            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(value),
        ],
      ),
    );
  }

  Widget buildPrice(
    String title,
    int value, {
    bool bold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,

          style: TextStyle(
            fontWeight:
                bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),

        Text(
          "Rp $value",

          style: TextStyle(
            fontWeight:
                bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}