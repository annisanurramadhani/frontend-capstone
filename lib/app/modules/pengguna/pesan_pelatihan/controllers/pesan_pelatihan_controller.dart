import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../routes/app_pages.dart';
import '../../../../data/services/pengguna_service.dart';

class PesanPelatihanController extends GetxController {
  RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  late Map pengrajin;
  late Map kelas;

  final namaController = TextEditingController();

  final noTelponController = TextEditingController();

  final tanggalController = TextEditingController();

  RxString jamPelatihan = "".obs;

  RxString metodeBayar = "".obs;

  final List<String> jamList = [
    "09.00 - 11.00",
    "11.30 - 13.30",
    "14.00 - 16.00",
  ];

  final List<Map<String, dynamic>> metodePembayaran = [
    {"nama": "GoPay", "kode": "GOPAY"},
  ];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    pengrajin = args["pengrajin"];
    kelas = args["kelas"];

    // DEBUG - hapus setelah fix
    print("=== DEBUG ARGS ===");
    print("PENGRAJIN: $pengrajin");
    print("PENGRAJIN ID: ${pengrajin["id"]}");
    print("==================");
  }

  Future<void> lanjutBooking() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (jamPelatihan.value.isEmpty) {
      Get.snackbar("Error", "Pilih jam pelatihan");

      return;
    }

    if (metodeBayar.value.isEmpty) {
      Get.snackbar("Error", "Pilih metode pembayaran");

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

        "metodeBayar": metodeBayar.value,
      };

      final response = await PenggunaService.createBooking(data: bookingData);

      if (response["success"] != true) {
        Get.snackbar("Error", response["message"] ?? "Booking gagal");
        return;
      }

      final payment = response["payment"];
      final booking = response["booking"];

      // Navigate ke halaman pembayaran
      Get.toNamed(
        Routes.PEMBAYARAN_PELATIHAN,
        arguments: {
          "metodeBayar": payment["metodeBayar"],
          "orderId": booking["orderId"] ?? "",
          "redirectUrl": payment["redirect_url"],
          "amount": booking["totalBayar"] is int
              ? booking["totalBayar"]
              : int.tryParse(booking["totalBayar"].toString()) ?? 0,
          "namaKelas": kelas["namaKelas"],
          "vaNumber": payment["vaNumber"] ?? "", // jika backend kirim vaNumber
        },
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
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
