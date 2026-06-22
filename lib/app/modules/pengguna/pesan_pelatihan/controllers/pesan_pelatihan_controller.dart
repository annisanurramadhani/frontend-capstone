import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../data/services/pengguna_service.dart';
import '../views/pesan_pelatihan_view.dart';

class PesanPelatihanController extends GetxController {
  RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  late Map pengrajin;
  late Map kelas;

  final namaController = TextEditingController();
  final noTelponController = TextEditingController();
  final tanggalController = TextEditingController();

  RxString jamPelatihan = "".obs;

  final List<String> jamList = [
    "09.00 - 11.00",
    "11.30 - 13.30",
    "14.00 - 16.00",
  ];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    pengrajin = args["pengrajin"];
    kelas = args["kelas"];

    print("=== DEBUG ARGS ===");
    print("PENGRAJIN: $pengrajin");
    print("PENGRAJIN ID: ${pengrajin["id"]}");
    print("==================");
  }

  Future<void> lanjutBooking() async {
    if (!formKey.currentState!.validate()) return;

    if (jamPelatihan.value.isEmpty) {
      Get.snackbar(
        "Error",
        "Pilih jam pelatihan",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;

      final box = GetStorage();
      final user = box.read("user");

      final bookingData = {
        "userId": user["id"],
        "pengrajinId": pengrajin["id"],
        "kelasId": kelas["id"],
        "namaLengkap": namaController.text,
        "noTelpon": noTelponController.text,
        "tanggal": tanggalController.text,
        "jamPelatihan": jamPelatihan.value,
        "metodeBayar": "midtrans",
      };

      final response = await PenggunaService.createBooking(data: bookingData);

      if (response["success"] != true) {
        Get.snackbar(
          "Error",
          response["message"] ?? "Booking gagal",
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      final payment = response["payment"];
      final booking = response["booking"];

      final result = await Get.toNamed(
        "/payment-webview",
        arguments: {
          "url": payment["redirect_url"],
          "orderId": booking["orderId"],
        },
      );

      if (result == "success") {
        PesanPelatihanView.showSuccessDialog();
      }

      if (result == "cancel") {
        Get.snackbar(
          "Pembayaran",
          "Pembayaran dibatalkan",
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    noTelponController.dispose();
    tanggalController.dispose();
    super.onClose();
  }
}
