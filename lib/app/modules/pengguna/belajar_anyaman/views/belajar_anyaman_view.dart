import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../detail_video/views/detail_video_view.dart';

import '../controllers/belajar_anyaman_controller.dart';

import '../../../../data/providers/api_provider.dart';

class BelajarAnyamanView extends GetView<BelajarAnyamanController> {
  const BelajarAnyamanView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),

        elevation: 0,

        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Get.back();
          },

          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E2723)),
        ),

        title: const Text(
          "Belajar Anyaman",

          style: TextStyle(
            color: Color(0xFF3E2723),

            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {
        // LOADING
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // DATA KOSONG
        if (controller.videos.isEmpty) {
          return const Center(child: Text("Belum ada video tutorial"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),

          itemCount: controller.videos.length,

          itemBuilder: (context, index) {
            final video = controller.videos[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => const DetailVideoView(), arguments: video);
              },

              child: Container(
                margin: const EdgeInsets.only(bottom: 22),

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
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // THUMBNAIL
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),

                      child: Image.network(
                        "${ApiProvider.baseUrl}/uploads/${video["thumbnail"]}",

                        width: double.infinity,

                        height: 210,

                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,

                            height: 210,

                            color: Colors.grey[300],

                            child: const Center(
                              child: Icon(Icons.broken_image, size: 55),
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            video["title"],

                            maxLines: 2,

                            overflow: TextOverflow.ellipsis,

                            style: TextStyle(
                              fontSize: size.width * 0.055,

                              fontWeight: FontWeight.bold,

                              color: const Color(0xFF3E2723),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "Pelajari teknik anyaman bambu menggunakan tutorial interaktif.",

                            maxLines: 2,

                            overflow: TextOverflow.ellipsis,

                            style: TextStyle(
                              fontSize: size.width * 0.038,

                              color: Colors.brown,

                              height: 1.6,
                            ),
                          ),

                          const SizedBox(height: 18),

                          SizedBox(
                            width: double.infinity,

                            height: 52,

                            child: ElevatedButton.icon(
                              onPressed: () {
                                Get.to(
                                  () => const DetailVideoView(),

                                  arguments: video,
                                );
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5A3116),

                                foregroundColor: Colors.white,

                                elevation: 0,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),

                              icon: const Icon(Icons.play_arrow),

                              label: const Text(
                                "Lihat Tutorial",

                                style: TextStyle(
                                  fontSize: 16,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
