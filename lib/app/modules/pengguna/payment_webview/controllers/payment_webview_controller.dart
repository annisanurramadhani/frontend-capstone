import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../data/services/pengguna_service.dart';

class PaymentWebviewController extends GetxController {
  late WebViewController webViewController;
  RxBool isLoading = true.obs;
  late String url;
  late String orderId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    url = args["url"];
    orderId = args["orderId"];
    print("ORDER ID = $orderId");

    // Langsung memulai polling status pembayaran di background
    cekStatusPembayaran();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            isLoading.value = true;
          },
          onPageFinished: (_) {
            isLoading.value = false;
          },
          onNavigationRequest: (request) {
            print("URL = ${request.url}");

            // Menangkap callback jika pembayaran berhasil (Sukses)
            if (request.url.contains("success") || 
                request.url.contains("settlement") || 
                request.url.contains("capture")) {
              Get.back(result: "success");
              return NavigationDecision.prevent;
            }

            // Menangkap callback jika pembayaran dibatalkan / gagal
            if (request.url.contains("cancel") || request.url.contains("deny")) {
              Get.back(result: "cancel");
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Future<void> cekStatusPembayaran() async {
    print("CEK STATUS DIMULAI");
    for (int i = 0; i < 60; i++) {
      await Future.delayed(const Duration(seconds: 3));
      try {
        final response = await PenggunaService.checkStatusBayar(orderId);
        print("RESPON STATUS: $response");

        if (response["success"] == true && response["statusBayar"] == "lunas") {
          print("STATUS LUNAS");
          Get.back(result: "success");
          return;
        }
      } catch (e) {
        print("ERROR CEK STATUS: $e");
      }
    }
    print("TIMEOUT CEK STATUS");
  }

  void reload() {
    webViewController.reload();
  }
}