import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class KeranjangController extends GetxController {
  RxBool isLoading = true.obs;

  RxList keranjangList = [].obs;

  RxInt totalHarga = 0.obs;

  @override
  void onInit() {
    super.onInit();

    getKeranjang();
  }

  Future<void> getKeranjang() async {
    try {
      isLoading.value = true;

      final response =
          await PenggunaService.getKeranjang();

      if (response["success"] == true) {
        keranjangList.assignAll(
          response["keranjang"],
        );

        hitungTotal();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void hitungTotal() {
    int total = 0;

    for (var item in keranjangList) {
      total +=
          (item["produk"]["harga"] as int) *
          (item["qty"] as int);
    }

    totalHarga.value = total;
  }

  Future<void> tambahQty(
    String keranjangId,
    int qtySekarang,
    int stok,
  ) async {
    try {
      if (qtySekarang >= stok) {
        Get.snackbar(
          "Info",
          "Stok tidak mencukupi",
        );
        return;
      }

      final qtyBaru =
          qtySekarang + 1;

      final response =
          await PenggunaService
              .updateKeranjangQty(
        keranjangId,
        qtyBaru,
      );

      if (response["success"] == true) {
        await getKeranjang();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

  Future<void> kurangQty(
    String keranjangId,
    int qtySekarang,
  ) async {
    try {
      if (qtySekarang <= 1) {
        return;
      }

      final qtyBaru =
          qtySekarang - 1;

      final response =
          await PenggunaService
              .updateKeranjangQty(
        keranjangId,
        qtyBaru,
      );

      if (response["success"] == true) {
        await getKeranjang();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

  Future<void> hapusKeranjang(
    String id,
  ) async {
    try {
      final response =
          await PenggunaService
              .deleteKeranjang(id);

      if (response["success"] == true) {
        await getKeranjang();

        Get.snackbar(
          "Berhasil",
          "Produk dihapus dari keranjang",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }
}