import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

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
          "Checkout",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF5A3116)),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // DATA PENERIMA
                    const Text(
                      "Data Penerima",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5A3116),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),
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
                        children: [
                          // NAMA
                          TextField(
                            onChanged: (value) =>
                                controller.namaPenerimaC.value = value,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF3E2723),
                            ),
                            decoration: InputDecoration(
                              labelText: "Nama Penerima",
                              labelStyle: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8B6347),
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Color(0xFF5A3116),
                                size: 20,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFDF8F3),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B5E3C),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // NO TELPON
                          TextField(
                            onChanged: (value) =>
                                controller.noTelponC.value = value,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF3E2723),
                            ),
                            decoration: InputDecoration(
                              labelText: "No Telepon",
                              labelStyle: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8B6347),
                              ),
                              prefixIcon: const Icon(
                                Icons.phone_outlined,
                                color: Color(0xFF5A3116),
                                size: 20,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFDF8F3),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B5E3C),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ALAMAT
                          TextField(
                            onChanged: (value) =>
                                controller.alamatC.value = value,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF3E2723),
                            ),
                            decoration: InputDecoration(
                              labelText: "Alamat Pengiriman",
                              labelStyle: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8B6347),
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(bottom: 40),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: Color(0xFF5A3116),
                                  size: 20,
                                ),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFDF8F3),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B5E3C),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // PRODUK
                    const Text(
                      "Produk",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5A3116),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
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
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.keranjangList.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final item = controller.keranjangList[index];
                          final produk = item["produk"];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        produk["namaProduk"] ?? "",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF3E2723),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
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
                                  "Rp ${produk["harga"]}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5A3116),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // TOTAL
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F3EE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Pembayaran",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8B6347),
                            ),
                          ),
                          Obx(
                            () => Text(
                              "Rp ${controller.totalHarga.value}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E2723),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => controller.checkout(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5A3116),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Bayar Sekarang",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
      ),
    );
  }
}