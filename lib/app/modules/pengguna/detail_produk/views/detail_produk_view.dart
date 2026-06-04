// detail_produk_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_produk_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class DetailProdukView extends GetView<DetailProdukController> {
  const DetailProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // DETAIL PRODUK
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Obx(() {
          final produk = controller.produk;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: EdgeInsets.all(size.width * 0.055),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // HEADER
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },

                      icon: const Icon(
                        Icons.arrow_back_ios_new,

                        color: Color(0xFF5A3116),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "Detail Produk",

                          style: TextStyle(
                            fontSize: size.width * 0.07,

                            fontWeight: FontWeight.bold,

                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),

                SizedBox(height: size.height * 0.025),

                // IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),

                  child: Image.network(
                    produk["gambar"] ?? "",

                    width: double.infinity,

                    height: size.height * 0.35,

                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: size.height * 0.35,

                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,

                          borderRadius: BorderRadius.circular(28),
                        ),

                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,

                            size: 60,

                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // CONTENT
                Container(
                  width: double.infinity,

                  padding: EdgeInsets.all(size.width * 0.055),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        produk["nama"] ?? "",

                        style: TextStyle(
                          fontSize: size.width * 0.075,

                          fontWeight: FontWeight.bold,

                          color: const Color(0xFF3E2723),
                        ),
                      ),

                      SizedBox(height: size.height * 0.012),

                      Text(
                        controller.formatRupiah(controller.hargaProduk),

                        style: TextStyle(
                          fontSize: size.width * 0.06,

                          fontWeight: FontWeight.bold,

                          color: const Color(0xFF5A3116),
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      Text(
                        produk["deskripsi"] ?? "",

                        style: TextStyle(
                          fontSize: size.width * 0.042,

                          color: Colors.black87,

                          height: 1.8,
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      // DETAIL
                      Container(
                        padding: EdgeInsets.all(size.width * 0.045),

                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F4EF),

                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: Column(
                          children: [
                            detailItem(
                              Icons.straighten,

                              "Ukuran",

                              produk["ukuran"] ?? "-",
                            ),

                            SizedBox(height: size.height * 0.02),

                            detailItem(
                              Icons.eco_outlined,

                              "Bahan",

                              produk["bahan"] ?? "-",
                            ),

                            SizedBox(height: size.height * 0.02),

                            detailItem(
                              Icons.inventory_2_outlined,

                              "Stok",

                              "${produk["stok"] ?? 0} pcs",
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      // JUMLAH
                      Row(
                        children: [
                          Text(
                            "Jumlah",

                            style: TextStyle(
                              fontSize: size.width * 0.055,

                              fontWeight: FontWeight.bold,

                              color: const Color(0xFF3E2723),
                            ),
                          ),

                          const Spacer(),

                          jumlahButton(Icons.remove, controller.kurangJumlah),

                          SizedBox(width: size.width * 0.04),

                          Obx(
                            () => Text(
                              controller.jumlah.value.toString(),

                              style: TextStyle(
                                fontSize: size.width * 0.06,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          SizedBox(width: size.width * 0.04),

                          jumlahButton(Icons.add, controller.tambahJumlah),
                        ],
                      ),

                      SizedBox(height: size.height * 0.035),

                      // TOTAL
                      Container(
                        padding: EdgeInsets.all(size.width * 0.05),

                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown.shade100),

                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(
                              "Total",

                              style: TextStyle(
                                fontSize: size.width * 0.05,

                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Obx(
                              () => Text(
                                controller.formatRupiah(controller.totalHarga),

                                style: TextStyle(
                                  fontSize: size.width * 0.06,

                                  fontWeight: FontWeight.bold,

                                  color: const Color(0xFF5A3116),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      SizedBox(
                        width: double.infinity,

                        height: 60,

                        child: ElevatedButton(
                          onPressed: controller.pilihPembayaran,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5A3116),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          child: Text(
                            "Pilih Pembayaran",

                            style: TextStyle(
                              fontSize: size.width * 0.045,

                              fontWeight: FontWeight.bold,

                              color: Colors.white,
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
      ),
    );
  }

  Widget detailItem(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Icon(icon, color: const Color(0xFF5A3116)),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,

                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,

                style: const TextStyle(color: Colors.black87, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget jumlahButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(14),

      child: Container(
        width: 45,
        height: 45,

        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown.shade100),

          borderRadius: BorderRadius.circular(14),
        ),

        child: Icon(icon, color: const Color(0xFF5A3116)),
      ),
    );
  }
}
