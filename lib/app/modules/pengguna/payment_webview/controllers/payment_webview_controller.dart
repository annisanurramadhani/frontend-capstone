import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => isLoading.value = true,
          onPageFinished: (_) => isLoading.value = false,
          onNavigationRequest: (request) {
            final currentUrl = request.url;
            if (currentUrl.contains("transaction_status=settlement") ||
                currentUrl.contains("transaction_status=capture") ||
                currentUrl.contains("status_code=200")) {
              Get.back(result: "success");
              return NavigationDecision.prevent;
            }
            if (currentUrl.contains("transaction_status=cancel") ||
                currentUrl.contains("transaction_status=deny")) {
              Get.back(result: "cancel");
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  void reload() => webViewController.reload();
}
