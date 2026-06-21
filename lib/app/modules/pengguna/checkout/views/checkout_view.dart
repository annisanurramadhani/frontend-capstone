import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

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
          "Beli Sekarang",
          style: TextStyle(
            color: Color(0xFF5A3116),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      onChanged: (value) {
                        controller.namaPenerimaC.value = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Nama Penerima",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      onChanged: (value) {
                        controller.noTelponC.value = value;
                      },
                      decoration: InputDecoration(
                        labelText: "No Telepon",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      maxLines: 3,
                      onChanged: (value) {
                        controller.alamatC.value = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Alamat",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Produk",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                      ),
                    ),

                    const SizedBox(height: 12),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.keranjangList.length,
                      itemBuilder: (context, index) {
                        final item = controller.keranjangList[index];
                        final produk = item["produk"];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Text(
                              produk["namaProduk"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("Jumlah : ${item["qty"]}"),
                            trailing: Text(
                              "Rp ${produk["harga"]}",
                              style: const TextStyle(
                                color: Color(0xFF5A3116),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    Obx(
                      () => Text(
                        "Total : Rp ${controller.totalHarga.value}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    DropdownButtonFormField(
                      value: controller.metodeBayar.value,
                      items: const [
                        DropdownMenuItem(value: "qris", child: Text("QRIS")),
                        DropdownMenuItem(
                          value: "bank_transfer",
                          child: Text("Transfer Bank"),
                        ),
                      ],
                      onChanged: (value) {
                        controller.metodeBayar.value = value.toString();
                      },
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
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
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
