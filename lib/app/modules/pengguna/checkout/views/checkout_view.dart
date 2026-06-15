import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView
    extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),

      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child:
                    CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.all(16),

                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        controller
                            .namaPenerimaC
                            .value = value;
                      },
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Nama Penerima",
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      onChanged: (value) {
                        controller
                            .noTelponC
                            .value = value;
                      },
                      decoration:
                          const InputDecoration(
                        labelText:
                            "No Telepon",
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      maxLines: 3,
                      onChanged: (value) {
                        controller
                            .alamatC
                            .value = value;
                      },
                      decoration:
                          const InputDecoration(
                        labelText: "Alamat",
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Align(
                      alignment:
                          Alignment.centerLeft,
                      child: Text(
                        "Produk",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),

                      itemCount: controller
                          .keranjangList.length,

                      itemBuilder:
                          (context, index) {
                        final item = controller
                            .keranjangList[index];

                        final produk =
                            item["produk"];

                        return Card(
                          child: ListTile(
                            title: Text(
                              produk[
                                  "namaProduk"],
                            ),
                            subtitle: Text(
                              "Qty : ${item["qty"]}",
                            ),
                            trailing: Text(
                              "Rp ${produk["harga"]}",
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    Obx(
                      () => Text(
                        "Total : Rp ${controller.totalHarga.value}",
                        style:
                            const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    DropdownButtonFormField(
                      value:
                          controller.metodeBayar.value,

                      items: const [
                        DropdownMenuItem(
                          value: "qris",
                          child: Text("QRIS"),
                        ),
                        DropdownMenuItem(
                          value: "bank_transfer",
                          child: Text(
                            "Transfer Bank",
                          ),
                        ),
                      ],

                      onChanged: (value) {
                        controller
                                .metodeBayar
                                .value =
                            value.toString();
                      },
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {
                          controller
                              .checkout();
                        },

                        child: const Text(
                          "Bayar Sekarang",
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