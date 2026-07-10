import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_navbar.dart';
import '../controllers/checkout_controller.dart';
import '../../../../data/providers/api_provider.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),

      bottomNavigationBar: const CustomNavbar(currentIndex: -1),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF5A3116)),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.05,
              vertical: h * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 48,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          splashRadius: 22,
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: w * 0.055,
                            color: const Color(0xFF5A3116),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            "Pesan Sekarang",
                            style: TextStyle(
                              fontSize: w * 0.065,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3E2723),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                SizedBox(height: h * 0.004),

                Center(
                  child: SizedBox(
                    width: w * 0.82,
                    child: Text(
                      "Lengkapi data penerima sebelum melakukan pembayaran",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.034,
                        color: Colors.grey,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: h * 0.02),

                const Text(
                  "Data Penerima",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5A3116),
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) =>
                            controller.namaPenerimaC.value = value,
                        decoration: InputDecoration(
                          labelText: "Nama Penerima",
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Color(0xFF5A3116),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8F5F1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) =>
                            controller.noTelponC.value = value,
                        decoration: InputDecoration(
                          labelText: "No. Telepon",
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            color: Color(0xFF5A3116),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8F5F1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.brown.shade100,
                            ),
                          ),

                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(
                              color: Color(0xFF8B5E3C),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: controller.kabupaten.value.isEmpty
                              ? null
                              : controller.kabupaten.value,
                          decoration: InputDecoration(
                            labelText: "Kabupaten / Kota",
                            prefixIcon: const Icon(
                              Icons.location_city,
                              color: Color(0xFF5A3116),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8F5F1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: controller.kabupatenList
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: (value) async {
                            controller.kabupaten.value = value!;

                            controller.kecamatan.value = "";

                            controller.kecamatanList.clear();

                            controller.ongkir.value = 0;

                            await controller.loadKecamatan(value);
                          },
                        ),
                      ),

                      const SizedBox(height: 14),

                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: controller.kecamatan.value.isEmpty
                              ? null
                              : controller.kecamatan.value,
                          decoration: InputDecoration(
                            labelText: "Kecamatan",
                            prefixIcon: const Icon(
                              Icons.map_outlined,
                              color: Color(0xFF5A3116),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8F5F1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: controller.kecamatanList
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: (value) async {
                            controller.kecamatan.value = value!;

                            await controller.loadOngkir(value);
                          },
                        ),
                      ),

                      const SizedBox(height: 14),

                      TextField(
                        maxLines: 3,
                        onChanged: (value) => controller.alamatC.value = value,
                        decoration: InputDecoration(
                          labelText: "Alamat Pengiriman",
                          alignLabelWithHint: true,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(bottom: 45),
                            child: Icon(
                              Icons.location_on_outlined,

                              color: Color(0xFF5A3116),
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8F5F1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  "Produk",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5A3116),
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.keranjangList.length,
                    separatorBuilder: (_, __) =>
                        Divider(height: 1, color: Colors.grey.shade200),
                    itemBuilder: (context, index) {
                      final item = controller.keranjangList[index];
                      final produk = item["produk"];

                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                produk["foto"].toString().startsWith("http")
                                    ? produk["foto"]
                                    : "${ApiProvider.baseUrl}${produk["foto"]}",
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return Container(
                                    width: 70,
                                    height: 70,
                                    color: const Color(0xFFF3EAE0),
                                    child: const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Color(0xFF5A3116),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    produk["namaProduk"] ?? "",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3E2723),
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    "Jumlah : ${item["qty"]}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    "Rp ${(produk["harga"] as int) * (item["qty"] as int)}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5A3116),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Subtotal Produk",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Text("Rp ${controller.totalHarga.value}"),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Ongkos Kirim",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Obx(() => Text("Rp ${controller.ongkir.value}")),
                            ],
                          ),

                          const Divider(height: 30),

                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Total Pembayaran",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Text(
                                  "Rp ${controller.totalBayar.value}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5A3116),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.checkout();
                          },
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
}