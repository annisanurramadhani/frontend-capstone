import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../detail_video/views/detail_video_view.dart';
import '../controllers/belajar_anyaman_controller.dart';
import '../../../../data/providers/api_provider.dart';

class BelajarAnyamanView extends GetView<BelajarAnyamanController> {
  const BelajarAnyamanView({super.key});

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
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF3E2723), size: 20),
        ),
        title: const Text(
          "Belajar Anyaman",
          style: TextStyle(
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(() {
        // ── LOADING ──────────────────────────────────────────────────
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF5A3116)),
          );
        }

        // ── KOSONG ───────────────────────────────────────────────────
        if (controller.videos.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EAE0),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.video_library_outlined,
                      size: 40, color: Color(0xFF5A3116)),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Belum ada video tutorial",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E2723),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Cek kembali nanti ya",
                  style: TextStyle(fontSize: 13, color: Color(0xFF8B6347)),
                ),
              ],
            ),
          );
        }

        // ── LIST ─────────────────────────────────────────────────────
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.videos.length,
          itemBuilder: (context, index) {
            final video = controller.videos[index];
            return _VideoCard(video: video);
          },
        );
      }),
    );
  }
}

// ── VIDEO CARD ───────────────────────────────────────────────────────────────

class _VideoCard extends StatelessWidget {
  final Map<String, dynamic> video;
  const _VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const DetailVideoView(), arguments: video),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF0E6DD), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── THUMBNAIL ────────────────────────────────────────────
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.network(
                    "${ApiProvider.baseUrl}/uploads/${video["thumbnail"]}",
                    width: double.infinity,
                    height: 190,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 190,
                      color: const Color(0xFFF3EAE0),
                      child: const Icon(
                        Icons.broken_image_outlined,
                        size: 48,
                        color: Color(0xFF8B6347),
                      ),
                    ),
                  ),
                  // play button overlay
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── INFO ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EAE0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Tutorial",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5A3116),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // judul
                  Text(
                    video["title"] ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3E2723),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // deskripsi
                  const Text(
                    "Pelajari teknik anyaman bambu menggunakan tutorial interaktif.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8B6347),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // tombol
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          Get.to(() => const DetailVideoView(), arguments: video),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A3116),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow_rounded, size: 20),
                      label: const Text(
                        "Lihat Tutorial",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
  }
}