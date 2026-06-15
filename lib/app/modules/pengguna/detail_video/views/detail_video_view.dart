import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailVideoView extends StatefulWidget {
  const DetailVideoView({super.key});

  @override
  State<DetailVideoView> createState() => _DetailVideoViewState();
}

class _DetailVideoViewState extends State<DetailVideoView> {
  late YoutubePlayerController playerController;

  @override
  void initState() {
    super.initState();
    final video = Get.arguments;
    final videoId = YoutubePlayer.convertUrlToId(video["videoUrl"]);
    playerController = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = Get.arguments;

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: playerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xFF5A3116),
      ),
      builder: (context, player) {
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
              "Tutorial Anyaman",
              style: TextStyle(
                color: Color(0xFF3E2723),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── VIDEO PLAYER ──────────────────────────────────────
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                  child: player,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── BADGE ───────────────────────────────────────
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
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

                      const SizedBox(height: 10),

                      // ── JUDUL ────────────────────────────────────────
                      Text(
                        video["title"] ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3E2723),
                          height: 1.35,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ── DESKRIPSI ────────────────────────────────────
                      Text(
                        video["description"] ??
                            "Belajar anyaman bambu menggunakan Computer Vision.",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8B6347),
                          height: 1.65,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ── DIVIDER ──────────────────────────────────────
                      const Divider(color: Color(0xFFF0E6DD), thickness: 1),

                      const SizedBox(height: 24),

                      // ── COMPUTER VISION CARD ─────────────────────────
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5A3116),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8B5E3C),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Color(0xFFFFE0B2),
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Computer Vision",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "Deteksi gerakan tangan real-time",
                                        style: TextStyle(
                                          color: Color(0xFFD7B899),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            const Text(
                              "Gunakan kamera untuk mendeteksi gerakan tangan dan mendapatkan panduan anyaman secara langsung.",
                              style: TextStyle(
                                color: Color(0xFFD7B899),
                                fontSize: 13,
                                height: 1.6,
                              ),
                            ),

                            const SizedBox(height: 18),

                            SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Get.snackbar(
                                    "Computer Vision",
                                    "Fitur segera hadir",
                                    backgroundColor: const Color(0xFF3E2723),
                                    colorText: Colors.white,
                                    borderRadius: 14,
                                    margin: const EdgeInsets.all(16),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF5A3116),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                  size: 18,
                                ),
                                label: const Text(
                                  "Mulai Deteksi",
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
              ],
            ),
          ),
        );
      },
    );
  }
}
