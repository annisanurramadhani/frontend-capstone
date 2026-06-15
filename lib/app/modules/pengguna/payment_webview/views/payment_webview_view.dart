import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/payment_webview_controller.dart';

class PaymentWebviewView extends GetView<PaymentWebviewController> {
  const PaymentWebviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pembayaran",
          style: TextStyle(
            color: Color(0xFF5A3116),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF5A3116)),
        actions: [
          IconButton(
            onPressed: controller.reload,
            icon: const Icon(Icons.refresh, color: Color(0xFF5A3116)),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller.webViewController),
          Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF8B5E3C)),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
