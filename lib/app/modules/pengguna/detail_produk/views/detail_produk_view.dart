import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../data/services/pengguna_service.dart';
import '../../../../global_widgets/custom_navbar.dart';
import '../controllers/detail_produk_controller.dart';

class DetailProdukView extends GetView<DetailProdukController> {
  const DetailProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          backgroundColor: Color(0xFFF8F5F1),
          body: Center(
            child: CircularProgressIndicator(color: Color(0xFF5A3116)),
          ),
        );
      }

      final produk = controller.produk;
      final size = MediaQuery.of(context).size;
      final w = size.width;
      final h = size.height;

      return Scaffold(
        backgroundColor: const Color(0xFFF8F5F1),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                Builder(
                  builder: (context) {
                    final size = MediaQuery.of(context).size;
                    final w = size.width;
                    final h = size.height;

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                          child: SizedBox(
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
                                      "Detail Produk",
                                      style: TextStyle(
                                        fontSize: w * 0.065,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF3E2723),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 48,
                                  child: IconButton(
                                    onPressed: () {
                                      Get.toNamed("/keranjang");
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    splashRadius: 22,
                                    icon: Icon(
                                      Icons.shopping_cart_outlined,
                                      size: w * 0.055,
                                      color: const Color(0xFF5A3116),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: h * 0.004),

                        SizedBox(
                          width: w * 0.82,
                          child: Text(
                            "Informasi lengkap mengenai produk",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: w * 0.034,
                              color: Colors.grey,
                              height: 1.4,
                            ),
                          ),
                        ),

                        SizedBox(height: h * 0.02),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      "${ApiProvider.baseUrl}${produk["foto"]}",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) {
                          return child;
                        }

                        return Container(
                          width: double.infinity,
                          height: 280,
                          color: const Color(0xFFF3EAE0),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF5A3116),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        width: double.infinity,
                        height: 280,
                        color: const Color(0xFFF3EAE0),
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          size: 60,
                          color: Color(0xFF5A3116),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
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

                        const SizedBox(height: 8),

                        Text(
                          "Rp ${produk["harga"]}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5A3116),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _infoRow(
                          icon: Icons.category_outlined,
                          label: "Kategori",
                          value: produk["kategori"] ?? "-",
                        ),

                        const Divider(height: 26),

                        _infoRow(
                          icon: Icons.straighten_outlined,
                          label: "Ukuran",
                          value: produk["ukuran"] ?? "-",
                        ),

                        const Divider(height: 26),

                        _infoRow(
                          icon: Icons.texture_outlined,
                          label: "Bahan",
                          value: produk["bahan"] ?? "-",
                        ),

                        const Divider(height: 26),

                        _infoRow(
                          icon: Icons.inventory_2_outlined,
                          label: "Stok",
                          value: "${produk["stok"]}",
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Deskripsi",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          produk["deskripsi"] ?? "-",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            height: 1.7,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          try {
                            final response =
                                await PenggunaService.createKeranjang(
                                  produkId: produk["id"],
                                  qty: 1,
                                );

                            if (response["success"] == true) {
                              Get.snackbar(
                                "Berhasil",
                                "Produk ditambahkan ke keranjang",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            } else {
                              Get.snackbar(
                                "Gagal",
                                response["message"] ?? "Terjadi kesalahan",
                              );
                            }
                          } catch (e) {
                            Get.snackbar("Error", e.toString());
                          }
                        },
                        label: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Masukkan Keranjang",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF5A3116),
                          side: const BorderSide(color: Color(0xFF5A3116)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(
                            "/checkout",
                            arguments: {
                              "mode": "beliLangsung",
                              "produk":
                                  produk, // kirim seluruh map produk (id, namaProduk, harga, foto, dll)
                              "qty": 1,
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5A3116),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Beli Sekarang",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const CustomNavbar(currentIndex: -1),
          ],
        ),
      );
    });
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFF3EAE0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF5A3116)),
        ),

        const SizedBox(width: 14),

        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF8B6347)),
          ),
        ),

        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3E2723),
            ),
          ),
        ),
      ],
    );
  }
}
