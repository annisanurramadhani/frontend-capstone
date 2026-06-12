import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/beri_rating_controller.dart';

class BeriRatingView extends GetView<BeriRatingController> {
  const BeriRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beri Rating")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              controller.pengrajinNama,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

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
                      Icons.star,
                      size: 40,
                      color: index < controller.rating.value
                          ? Colors.amber
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller.ulasanController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Tulis ulasan...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitReview,
                  child: const Text("Kirim Rating"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
