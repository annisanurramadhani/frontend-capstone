// pemesanan_produk_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pemesanan_produk_controller.dart';

class PemesananProdukView extends GetView<PemesananProdukController> {
  const PemesananProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      appBar: AppBar(
        title: const Text("Pemesanan Produk"),

        centerTitle: true,

        elevation: 0,

        backgroundColor: const Color(0xFFFDF8F3),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: controller.formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // PRODUK
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Produk Dipilih",

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
                      "Rp ${controller.hargaProduk}",

                      style: const TextStyle(
                        color: Color(0xFF5A3116),

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Informasi Penerima",

                style: TextStyle(
                  fontSize: 18,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: controller.namaController,

                decoration: InputDecoration(
                  labelText: "Nama Lengkap",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama wajib diisi";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: controller.noTelponController,

                keyboardType: TextInputType.phone,

                decoration: InputDecoration(
                  labelText: "Nomor Telepon",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nomor telepon wajib diisi";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.kecamatan.value.isEmpty
                      ? null
                      : controller.kecamatan.value,

                  decoration: InputDecoration(
                    labelText: "Kecamatan",

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  items: controller.daftarKecamatan
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,

                          child: Text(e),
                        ),
                      )
                      .toList(),

                  onChanged: (value) {
                    controller.pilihKecamatan(value!);
                  },
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: controller.alamatController,

                maxLines: 4,

                decoration: InputDecoration(
                  labelText: "Alamat Lengkap",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Alamat wajib diisi";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              const Text(
                "Ringkasan Pembayaran",

                style: TextStyle(
                  fontSize: 18,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Obx(
                  () => Column(
                    children: [
                      buildRow(
                        "Harga Produk",
                        controller.hargaProduk,
                      ),

                      const SizedBox(height: 10),

                      buildRow(
                        "Ongkir",
                        controller.ongkir.value,
                      ),

                      const Divider(height: 25),

                      buildRow(
                        "Total Pembayaran",
                        controller.totalPembayaran,
                        bold: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                height: 55,

                child: ElevatedButton(
                  onPressed: controller.lanjutPembayaran,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A3116),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  child: const Text(
                    "Lanjut Pembayaran",

                    style: TextStyle(
                      color: Colors.white,

                      fontWeight: FontWeight.bold,
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

  Widget buildRow(
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
            fontWeight: bold
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),

        Text(
          "Rp $value",

          style: TextStyle(
            fontWeight: bold
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}