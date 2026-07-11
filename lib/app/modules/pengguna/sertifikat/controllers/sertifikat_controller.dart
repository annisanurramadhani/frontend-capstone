import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../data/services/pengguna_service.dart';

class SertifikatController extends GetxController {
  RxBool isLoading = true.obs;

  RxList sertifikatList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getSertifikat();
  }

  Future<void> getSertifikat() async {
    try {
      isLoading.value = true;

      final response =
          await PenggunaService.getSertifikat();

      print("=== RESPONSE SERTIFIKAT ===");
      print(response);

      if (response["success"] == true) {
        sertifikatList.assignAll(
          response["sertifikat"] ?? [],
        );
      }
    } catch (e) {
      print("ERROR SERTIFIKAT:");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void kembali() {
    Get.back();
  }

Future<void> lihatSertifikat(
    dynamic data,
  ) async {
    if (data["sertifikatUrl"] == null) {
      Get.snackbar(
        "Gagal",
        "Sertifikat tidak ditemukan",
      );
      return;
    }

    // --- LOGIKA BARU UNTUK CEK URL ---
    String rawUrl = data["sertifikatUrl"];
    String url = rawUrl.startsWith("http") 
        ? rawUrl 
        : "${ApiProvider.baseUrl}$rawUrl";
    // ---------------------------------

    await launchUrl(
      Uri.parse(
        Uri.encodeFull(url),
      ),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> unduhPdf(
    dynamic data,
  ) async {
    try {
      if (data["sertifikatUrl"] == null) {
        Get.snackbar(
          "Gagal",
          "Sertifikat tidak ditemukan",
        );
        return;
      }

      // --- LOGIKA BARU UNTUK CEK URL ---
      String rawUrl = data["sertifikatUrl"];
      String url = rawUrl.startsWith("http") 
          ? rawUrl 
          : "${ApiProvider.baseUrl}$rawUrl";
      // ---------------------------------

      final directory =
          await getApplicationDocumentsDirectory();

      final namaFile =
          "sertifikat_${data["id"]}.pdf";

      final filePath =
          "${directory.path}/$namaFile";

      Get.dialog(
        const Center(
          child:
              CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      await Dio().download(
        Uri.encodeFull(url),
        filePath,
      );

      Get.back();

      Get.snackbar(
        "Berhasil",
        "Sertifikat berhasil diunduh",
      );

      await OpenFilex.open(
        filePath,
      );
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      print(e);

      Get.snackbar(
        "Gagal",
        "Tidak dapat mengunduh sertifikat",
      );
    }
  }
}