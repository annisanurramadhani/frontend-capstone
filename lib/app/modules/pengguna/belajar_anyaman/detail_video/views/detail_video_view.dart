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
  Widget build(BuildContext context) {
    final video = Get.arguments;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),

        title: const Text("Tutorial Anyaman"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // VIDEO PLAYER
            ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: YoutubePlayer(
                controller: playerController,

                showVideoProgressIndicator: true,
              ),
            ),

            SizedBox(height: size.height * 0.03),

            // TITLE
            Text(
              video["title"],

              style: TextStyle(
                fontSize: size.width * 0.07,

                fontWeight: FontWeight.bold,

                color: const Color(0xFF3E2723),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            // DESKRIPSI
            Text(
              video["description"] ??
                  "Belajar anyaman bambu menggunakan Computer Vision.",

              style: TextStyle(
                fontSize: size.width * 0.042,

                color: Colors.brown,

                height: 1.7,
              ),
            ),

            SizedBox(height: size.height * 0.04),

            // COMPUTER VISION
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFF5A3116),

                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Computer Vision",

                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 22,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Gunakan kamera untuk mendeteksi gerakan tangan.",

                    style: TextStyle(color: Colors.white, height: 1.7),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    height: 52,

                    child: ElevatedButton(
                      onPressed: () {
                        Get.snackbar("Computer Vision", "Fitur segera hadir");
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,

                        foregroundColor: const Color(0xFF5A3116),
                      ),

                      child: const Text("Mulai Deteksi"),
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

  @override
  void dispose() {
    playerController.dispose();

    super.dispose();
  }
}
