import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lihat_pesanan_controller.dart';

class LihatPesananView extends GetView<LihatPesananController> {
  const LihatPesananView({super.key});

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
          "Riwayat Pembelian",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF5A3116)),
          );
        }

        if (controller.pesananList.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 64,
                  color: Color(0xFFD7C4B0),
                ),
                SizedBox(height: 16),
                Text(
                  "Belum ada pesanan",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF8B6347),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: controller.pesananList.length,
          itemBuilder: (context, index) {
            final pesanan = controller.pesananList[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8F3EE),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.receipt_outlined,
                          size: 16,
                          color: Color(0xFF8B6347),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            pesanan["orderId"] ?? "-",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8B6347),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // STATUS ROW
                        Row(
                          children: [
                            _statusBadge(
                              label: pesanan["statusBayar"] ?? "-",
                              isGreen: pesanan["statusBayar"] == "lunas" ||
                                  pesanan["statusBayar"] == "settlement",
                            ),
                            const SizedBox(width: 8),
                            _statusBadge(
                              label: pesanan["statusPesanan"] ?? "-",
                              isGreen: pesanan["statusPesanan"] == "selesai",
                              isBlue: pesanan["statusPesanan"] == "dikirim",
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),
                        const Divider(height: 1),
                        const SizedBox(height: 14),

                        // DETAIL ITEM
                        ...List.generate(
                          pesanan["detailPesanan"].length,
                          (i) {
                            final item = pesanan["detailPesanan"][i];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["produk"]["namaProduk"] ?? "-",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF3E2723),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          "Qty: ${item["qty"]}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF8B6347),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Rp ${item["subtotal"]}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF5A3116),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        const Divider(height: 1),
                        const SizedBox(height: 12),

                        // TOTAL
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Pembayaran",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8B6347),
                              ),
                            ),
                            Text(
                              "Rp ${pesanan["totalBayar"]}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E2723),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _statusBadge({
    required String label,
    bool isGreen = false,
    bool isBlue = false,
  }) {
    Color bg;
    Color text;

    if (isGreen) {
      bg = const Color(0xFFDCF5E7);
      text = const Color(0xFF1A7A4A);
    } else if (isBlue) {
      bg = const Color(0xFFDBEAFD);
      text = const Color(0xFF1A56B0);
    } else {
      bg = const Color(0xFFFFF3CD);
      text = const Color(0xFF856404);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }
}