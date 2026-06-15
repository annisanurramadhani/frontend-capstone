import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/services/pengguna_service.dart';
import '../../../../routes/app_pages.dart';

class PembayaranPelatihanController extends GetxController {
  late String metodeBayar;
  late String orderId;
  late String redirectUrl;
  late int amount;
  late String namaKelas;

  RxString statusBayar = "menunggu".obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    metodeBayar = args["metodeBayar"];
    orderId = args["orderId"];
    redirectUrl = args["redirectUrl"] ?? "";
    amount = args["amount"];
    namaKelas = args["namaKelas"];

    print("ORDER ID POLLING: $orderId");

    startPolling();
  }

  void startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await cekStatus();
    });
  }

  Future<void> cekStatus() async {
    try {
      final response = await PenggunaService.checkStatusBayar(orderId);

      if (response["success"] == true) {
        statusBayar.value = response["statusBayar"] ?? "menunggu";

        if (statusBayar.value == "lunas") {
          _timer?.cancel();

          await Get.dialog(
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 80),

                  const SizedBox(height: 16),

                  const Text(
                    "Pembayaran Berhasil",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Booking pelatihan berhasil dikonfirmasi",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();

                        Get.offAllNamed(Routes.RIWAYAT_KELAS);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5E3C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            barrierDismissible: false,
          );
        }
      }
    } catch (e) {
      print("Polling error: $e");
    }
  }

  String get formattedAmount {
    return "Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}";
  }

  Future<void> bayarSekarang() async {
    final result = await Get.toNamed(
      "/payment-webview",
      arguments: {"url": redirectUrl, "orderId": orderId},
    );

    if (result == "success") {
      statusBayar.value = "lunas";

      _timer?.cancel();

      Get.snackbar(
        "Pembayaran Berhasil! 🎉",
        "Booking kamu sudah dikonfirmasi",
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
