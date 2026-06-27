import 'package:get/get.dart';

import '../../../../data/services/pengguna_service.dart';

class CheckoutController extends GetxController {
  RxBool isLoading = false.obs;

  RxList keranjangList = [].obs;

  RxInt totalHarga = 0.obs;

  final namaPenerimaC = "".obs;

  final noTelponC = "".obs;

  final alamatC = "".obs;

  RxList<String> kabupatenList = <String>[].obs;

  RxList<String> kecamatanList = <String>[].obs;

  RxString kabupaten = "".obs;

  RxString kecamatan = "".obs;

  RxInt ongkir = 0.obs;

  RxInt totalBayar = 0.obs;

  RxString metodeBayar = "qris".obs;

  @override
  void onInit() {
    super.onInit();

    loadKeranjang();
    loadKabupaten();
  }

  Future<void> loadKeranjang() async {
    try {
      isLoading.value = true;

      final response = await PenggunaService.getKeranjang();

      if (response["success"] == true) {
        keranjangList.assignAll(response["keranjang"]);

        hitungTotal();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadKabupaten() async {
    final response = await PenggunaService.getKabupaten();

    if (response["success"] == true) {
      kabupatenList.assignAll(List<String>.from(response["data"]));
    }
  }

  Future<void> loadKecamatan(String kabupaten) async {
    final response = await PenggunaService.getKecamatan(kabupaten);

    if (response["success"] == true) {
      kecamatanList.assignAll(List<String>.from(response["data"]));
    }
  }

  Future<void> loadOngkir(String kecamatan) async {
    final response = await PenggunaService.getOngkir(kecamatan);

    if (response["success"] == true) {
      ongkir.value = response["data"]["ongkir"];

      hitungTotal();
    }
  }

  void hitungTotal() {
    int total = 0;

    for (var item in keranjangList) {
      total += (item["qty"] as int) * (item["produk"]["harga"] as int);
    }

    totalHarga.value = total;

    totalBayar.value = total + ongkir.value;
  }

  Future<void> checkout() async {
    try {
      isLoading.value = true;

      final response = await PenggunaService.checkoutKeranjang(
        namaPenerima: namaPenerimaC.value,
        noTelpon: noTelponC.value,
        alamat: alamatC.value,
        kabupaten: kabupaten.value,
        kecamatan: kecamatan.value,
        ongkir: ongkir.value,
        metodeBayar: metodeBayar.value,
      );

      if (response["success"] == true) {
        final result = await Get.toNamed(
          "/payment-webview",
          arguments: {
            "url": response["payment"]["redirect_url"],

            "orderId": response["pesanan"]["orderId"],
          },
        );
        //POPUOP
        if (result == "success") {
          Get.defaultDialog(
            title: "Pembayaran Berhasil",
            middleText: "Pesanan berhasil dibayar",

            textConfirm: "OK",

            onConfirm: () {
              Get.back();

              Get.offAllNamed("/halaman-utama");
            },
          );
        }

        if (result == "cancel") {
          Get.snackbar("Pembayaran", "Pembayaran dibatalkan");
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}
