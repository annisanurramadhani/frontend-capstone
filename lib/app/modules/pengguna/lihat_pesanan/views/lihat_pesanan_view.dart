import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../global_widgets/custom_navbar.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/lihat_pesanan_controller.dart';

class LihatPesananView extends GetView<LihatPesananController> {
  const LihatPesananView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),

      bottomNavigationBar: const CustomNavbar(currentIndex: 0),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF5A3116)),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 56,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.HALAMAN_UTAMA);
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          splashRadius: 22,
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 22,
                            color: Color(0xFF5A3116),
                          ),
                        ),
                      ),

                      const Center(
                        child: Text(
                          "Riwayat Pembelian",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "Lihat semua pesanan Anda",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),

              const SizedBox(height: 18),

              SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _statusMenu(
                          title: "Semua",
                          icon: Icons.dashboard_customize_rounded,
                        ),
                      ),
                      _line(),
                      Expanded(
                        child: _statusMenu(
                          title: "Diterima",
                          icon: Icons.assignment_turned_in_outlined,
                        ),
                      ),
                      _line(),
                      Expanded(
                        child: _statusMenu(
                          title: "Dikemas",
                          icon: Icons.inventory_2_outlined,
                        ),
                      ),
                      _line(),
                      Expanded(
                        child: _statusMenu(
                          title: "Dikirim",
                          icon: Icons.local_shipping_outlined,
                        ),
                      ),
                      _line(),
                      Expanded(
                        child: _statusMenu(
                          title: "Selesai",
                          icon: Icons.verified_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: controller.filteredPesanan.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: w * 0.24,
                              height: w * 0.24,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF3EAE0),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                size: w * 0.11,
                                color: const Color(0xFF5A3116),
                              ),
                            ),

                            SizedBox(height: h * 0.025),

                            Text(
                              "Belum Ada Pesanan",
                              style: TextStyle(
                                fontSize: w * 0.05,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3E2723),
                              ),
                            ),

                            SizedBox(height: h * 0.008),

                            SizedBox(
                              width: w * 0.70,
                              child: Text(
                                "Produk yang Anda beli akan muncul di halaman ini.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: w * 0.034,
                                  color: Colors.grey,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 18,
                          bottom: 18,
                        ),
                        itemCount: controller.filteredPesanan.length,
                        itemBuilder: (context, index) {
                          final pesanan = controller.filteredPesanan[index];
                          final List detailList =
                              pesanan["detailPesanan"] ?? [];
                          final item = detailList.isNotEmpty
                              ? detailList[0]
                              : null;
                          final produk = item != null
                              ? item["produk"]
                              : null;

                          final String namaProduk =
                              produk?["namaProduk"] ?? "Produk";
                          final String? foto = produk?["foto"];
                          final int qty = item?["qty"] ?? 0;
                          final int jumlahItemLain =
                              detailList.length > 1
                                  ? detailList.length - 1
                                  : 0;

                          final String orderId =
                              pesanan["orderId"] ?? "-";
                          final String statusPesanan =
                              (pesanan["statusPesanan"] ?? "diproses")
                                  .toString();
                          final int totalBayar =
                              pesanan["totalBayar"] ?? 0;
                          final String createdAtRaw =
                              pesanan["createdAt"] ?? "";

                          String tanggalFormatted = "-";
                          try {
                            final date = DateTime.parse(createdAtRaw);
                            tanggalFormatted =
                                DateFormat("d MMM yyyy, HH:mm").format(date);
                          } catch (_) {}

                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Order #$orderId",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    _statusBadge(
                                      label: statusPesanan,
                                      isGreen:
                                          statusPesanan.toLowerCase() ==
                                              "selesai",
                                      isBlue:
                                          statusPesanan.toLowerCase() ==
                                                  "dikirim" ||
                                              statusPesanan.toLowerCase() ==
                                                  "diterima",
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  tanggalFormatted,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),

                                const Divider(height: 20),

                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      child: (foto != null &&
                                              foto.isNotEmpty)
                                          ? Image.network(
                                              produk["foto"].toString().startsWith("http")
                                                  ? produk["foto"]
                                                  : "${ApiProvider.baseUrl}${produk["foto"]}",
                                              width: 64,
                                              height: 64,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error,
                                                          stackTrace) =>
                                                      Container(
                                                width: 64,
                                                height: 64,
                                                color:
                                                    const Color(0xFFF3EAE0),
                                                child: const Icon(
                                                  Icons.image_not_supported,
                                                  color: Color(0xFF5A3116),
                                                  size: 22,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 64,
                                              height: 64,
                                              color:
                                                  const Color(0xFFF3EAE0),
                                              child: const Icon(
                                                Icons.image_outlined,
                                                color: Color(0xFF5A3116),
                                                size: 22,
                                              ),
                                            ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            namaProduk,
                                            maxLines: 1,
                                            overflow:
                                                TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF3E2723),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            jumlahItemLain > 0
                                                ? "$qty barang  •  +$jumlahItemLain produk lainnya"
                                                : "$qty barang",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const Divider(height: 20),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Belanja",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                        locale: "id_ID",
                                        symbol: "Rp ",
                                        decimalDigits: 0,
                                      ).format(totalBayar),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF5A3116),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _statusMenu({required String title, required IconData icon}) {
    final bool selected = controller.selectedStatus.value == title;

    return GestureDetector(
      onTap: () {
        controller.pilihStatus(title);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF5A3116)
                    : const Color(0xFFF3EAE0),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: selected ? Colors.white : const Color(0xFF5A3116),
                size: 18,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                color: selected
                    ? const Color(0xFF5A3116)
                    : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line() {
    return Container(
      width: 18,
      height: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFFE5D8CB),
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
      bg = const Color(0xFFE8F5E9);
      text = const Color(0xFF2E7D32);
    } else if (isBlue) {
      bg = const Color(0xFFE3F2FD);
      text = const Color(0xFF1565C0);
    } else {
      bg = const Color(0xFFFFF3E0);
      text = const Color(0xFFE65100);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: text,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}