import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_navbar.dart';
import '../controllers/beri_rating_controller.dart';
import '../../../../data/providers/api_provider.dart';

class BeriRatingView extends GetView<BeriRatingController> {
  const BeriRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),

      bottomNavigationBar: const CustomNavbar(currentIndex: -1),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.05,
            vertical: h * 0.02,
          ),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.065,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: const Color(0xFF5A3116),
                          size: w * 0.055,
                        ),
                      ),
                    ),

                    Text(
                      "Beri Rating",
                      style: TextStyle(
                        fontSize: w * 0.065,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3E2723),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.003),
              Center(
                child: SizedBox(
                  width: w * 0.82,
                  child: Text(
                    "Bagikan pengalaman Anda setelah mengikuti pelatihan.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w * 0.034,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Obx(
                      () => ClipOval(
                        child: controller.pengrajinPhoto.value.isNotEmpty
                            ? Image.network(
                                "${ApiProvider.baseUrl}${controller.pengrajinPhoto.value}",
                                width: w * 0.22,
                                height: w * 0.22,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return Container(
                                    width: w * 0.22,
                                    height: w * 0.22,
                                    color: const Color(0xFFF3EAE0),
                                    child: Icon(
                                      Icons.person,
                                      size: w * 0.11,
                                      color: const Color(0xFF5A3116),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                width: w * 0.22,
                                height: w * 0.22,
                                color: const Color(0xFFF3EAE0),
                                child: Icon(
                                  Icons.person,
                                  size: w * 0.11,
                                  color: const Color(0xFF5A3116),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    Obx(
                      () => Text(
                        controller.pengrajinNama.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: w * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      "Berikan penilaian Anda",
                      style: TextStyle(fontSize: 15, color: Colors.brown),
                    ),

                    const SizedBox(height: 14),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => IconButton(
                            splashRadius: 24,
                            onPressed: () {
                              controller.rating.value = index + 1;
                            },
                            icon: Icon(
                              Icons.star_rounded,
                              size: w * 0.09,
                              color: index < controller.rating.value
                                  ? Colors.amber
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(w * 0.04),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F5F1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        controller: controller.ulasanController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Ceritakan pengalaman Anda.....",
                          hintStyle: TextStyle(color: Colors.grey, height: 1.6),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: h * 0.065,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.submitReview,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A3116),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            "Kirim Rating",
                            style: TextStyle(
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),

              SizedBox(height: h * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}