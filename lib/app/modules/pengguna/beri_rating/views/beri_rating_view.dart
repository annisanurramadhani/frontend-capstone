import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/beri_rating_controller.dart';

class BeriRatingView extends GetView<BeriRatingController> {
  const BeriRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF3E2723),
            size: 20,
          ),
        ),

        title: const Text(
          "Beri Rating",
          style: TextStyle(
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Container(
          width: double.infinity,

          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(24),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,

                decoration: const BoxDecoration(
                  color: Color(0xFFF3EAE0),
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.person,
                  size: 45,
                  color: Color(0xFF5A3116),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                controller.pengrajinNama,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Bagaimana pengalaman Anda mengikuti pelatihan?",
                textAlign: TextAlign.center,

                style: TextStyle(color: Colors.brown, fontSize: 14),
              ),

              const SizedBox(height: 28),

              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: List.generate(
                    5,
                    (index) => IconButton(
                      onPressed: () {
                        controller.rating.value = index + 1;
                      },

                      icon: Icon(
                        Icons.star_rounded,
                        size: 42,

                        color: index < controller.rating.value
                            ? Colors.amber
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              TextField(
                controller: controller.ulasanController,
                maxLines: 5,

                decoration: InputDecoration(
                  hintText: "Tulis ulasan Anda...",

                  filled: true,
                  fillColor: const Color(0xFFF8F5F1),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF5A3116)),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.submitReview,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A3116),
                      foregroundColor: Colors.white,

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Kirim Rating",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
