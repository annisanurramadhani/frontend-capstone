// pembayaran_pelatihan_controller.dart

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class PembayaranPelatihanController
    extends GetxController {

  RxBool isLoading =
      false.obs;

  RxInt menit =
      23.obs;

  RxInt detik =
      59.obs;

  Timer? timer;

  RxMap<String, dynamic>
      pembayaran =
      <String, dynamic>{}.obs;

  RxMap<String, dynamic>
      metode =
      <String, dynamic>{}.obs;

  final String orderId =
      "ORD-20052024-12345";

  final String totalPembayaran =
      "Rp205.000";

  @override
  void onInit() {
    super.onInit();

    getData();

    mulaiTimer();
  }

  void getData() {

    final data =
        Get.arguments;

    if (data != null) {

      pembayaran.value =
          Map<String, dynamic>.from(
        data["kelas"],
      );

      metode.value =
          Map<String, dynamic>.from(
        data["metode"],
      );
    }
  }

  void kembali() {

    Get.back();
  }

  void mulaiTimer() {

    timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),

      (timer) {

        if (detik.value >
            0) {

          detik.value--;

        } else {

          if (menit.value >
              0) {

            menit.value--;

            detik.value =
                59;

          } else {

            timer.cancel();
          }
        }
      },
    );
  }

  void salinOrderId() {

    Clipboard.setData(
      ClipboardData(
        text: orderId,
      ),
    );

    Get.snackbar(
      "Berhasil",
      "Order ID berhasil disalin",
    );
  }

  void cekStatusPembayaran() {

    Get.toNamed(
      Routes.PEMBAYARAN_BERHASIL,

      arguments: {

        "tipe":
            "pelatihan",

        "order_id":
            orderId,

        "judul":
            "Pembayaran Berhasil",

        "subtitle":
            "Kelas berhasil dipesan dan jadwal sudah dikonfirmasi.",

        "button":
            "Lihat Jadwal",
      },
    );
  }

  @override
  void onClose() {

    timer?.cancel();

    super.onClose();
  }
}