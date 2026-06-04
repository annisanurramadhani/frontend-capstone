// pembayaran_produk_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pembayaran_produk_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class PembayaranProdukView extends GetView<PembayaranProdukController> {
  const PembayaranProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // PEMBAYARAN PRODUK
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF5A3116),
                      size: 28,
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Pembayaran Produk",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2723),
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Selesaikan pembayaran untuk memproses pesanan Anda",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 30),

              // Ringkasan
              sectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ringkasan Pesanan",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/produk1.jpg",
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Keranjang Bambu",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3E2723),
                                ),
                              ),

                              const SizedBox(height: 22),

                              itemRingkasan("Jumlah", "1 pcs"),

                              const SizedBox(height: 14),

                              itemRingkasan("Harga Satuan", "Rp 85.000"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F4EF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Subtotal",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const Text(
                            "Rp 85.000",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2723),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Alamat
              sectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Alamat Pengiriman",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Container(
                          width: 86,
                          height: 86,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F4EF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            size: 40,
                            color: Color(0xFF5A3116),
                          ),
                        ),

                        const SizedBox(width: 20),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Andi Pratama",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3E2723),
                                ),
                              ),

                              SizedBox(height: 10),

                              Text(
                                "Jl. Melati No. 45, Kel. Sukamaju, Kec. Cimahi Tengah, Kota Cimahi, Jawa Barat 40522",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                  height: 1.7,
                                ),
                              ),

                              SizedBox(height: 10),

                              Text(
                                "0812-3456-7890",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Metode pembayaran
              sectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pilih Metode Pembayaran",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Obx(
                      () => Column(
                        children: [
                          metodeItem(
                            title: "QRIS",
                            subtitle: "Bayar menggunakan QRIS semua aplikasi",
                            icon: Icons.qr_code,
                          ),

                          metodeItem(
                            title: "GoPay",
                            subtitle: "Bayar menggunakan saldo GoPay",
                            icon: Icons.account_balance_wallet,
                          ),

                          metodeItem(
                            title: "ShopeePay",
                            subtitle: "Bayar menggunakan saldo ShopeePay",
                            icon: Icons.shopping_bag,
                          ),

                          metodeItem(
                            title: "Transfer Bank",
                            subtitle: "Transfer manual ke rekening bank",
                            icon: Icons.account_balance,
                          ),

                          metodeItem(
                            title: "Virtual Account",
                            subtitle: "Bayar menggunakan Virtual Account",
                            icon: Icons.credit_card,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Total
              sectionContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Pembayaran",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2723),
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Sudah termasuk harga produk dan biaya layanan",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Text(
                      "Rp 85.000",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5A3116),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Button
              SizedBox(
                width: double.infinity,
                height: 82,
                child: ElevatedButton(
                  onPressed: controller.bayarSekarang,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A3116),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    "Bayar Sekarang",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield_outlined, size: 22, color: Colors.grey),

                  SizedBox(width: 10),

                  Text(
                    "Pembayaran aman & terenkripsi",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget itemRingkasan(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, color: Colors.black87),
        ),

        Text(
          value,
          style: const TextStyle(fontSize: 22, color: Colors.black87),
        ),
      ],
    );
  }

  Widget metodeItem({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final selected = controller.metodePembayaran.value == title;

    return GestureDetector(
      onTap: () {
        controller.pilihMetode(title);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF9F4EF) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.brown.shade100),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 30,
              color: selected ? const Color(0xFF5A3116) : Colors.grey,
            ),

            const SizedBox(width: 20),

            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F4EF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, size: 36, color: const Color(0xFF5A3116)),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
