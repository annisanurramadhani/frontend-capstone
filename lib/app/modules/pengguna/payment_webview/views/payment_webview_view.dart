import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/payment_webview_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class PaymentWebviewView extends GetView<PaymentWebviewController> {
  const PaymentWebviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      bottomNavigationBar: const CustomNavbar(currentIndex: -1),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 56,
                child: Row(
                  children: [
                    SizedBox(
                      width: 48,
                      child: IconButton(
                        onPressed: () {
                          Get.offAllNamed("/lihat-pesanan");
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 22,
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 22,
                          color: Color(0xFF5A3116),
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Center(
                        child: Text(
                          "Pembayaran",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 48,
                      child: IconButton(
                        onPressed: controller.reload,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 22,
                        icon: const Icon(
                          Icons.refresh,
                          size: 22,
                          color: Color(0xFF5A3116),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 4),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Selesaikan pembayaran untuk melanjutkan proses pesanan.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.4),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Stack(
                children: [
                  WebViewWidget(controller: controller.webViewController),

                  Obx(
                    () => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF8B5E3C),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
