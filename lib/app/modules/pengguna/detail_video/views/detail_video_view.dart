import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../data/providers/api_provider.dart';
import '../../../../data/services/pengguna_service.dart';

class DetailVideoView extends StatefulWidget {
  const DetailVideoView({super.key});

  @override
  State<DetailVideoView> createState() => _DetailVideoViewState();
}

class _DetailVideoViewState extends State<DetailVideoView> {
  late VideoPlayerController playerController;

  bool isReady = false;
  bool sudahKirimAktivitas = false;
  bool isFullscreen = false;
  bool showControls = true;

  @override
  void initState() {
    super.initState();

    final video = Get.arguments as Map<String, dynamic>;
    final videoUrl = "${ApiProvider.baseUrl}${video["videoUrl"]}";

    playerController = VideoPlayerController.networkUrl(
      Uri.parse(Uri.encodeFull(videoUrl)),
    );

    playerController.initialize().then((_) {
      if (mounted) {
        setState(() {
          isReady = true;
        });
      }
    });

    playerController.addListener(() async {
      if (sudahKirimAktivitas) return;
      final position = playerController.value.position;
      if (position.inSeconds >= 10) {
        sudahKirimAktivitas = true;
        try {
          await PenggunaService.createAktivitasVideo(video["id"]);
        } catch (_) {}
      }
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _exitFullscreen();
    playerController.dispose();
    super.dispose();
  }

  void _enterFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() {
      isFullscreen = true;
      showControls = true;
    });
  }

  void _exitFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    setState(() {
      isFullscreen = false;
      showControls = true;
    });
  }

  void _toggleControls() {
    setState(() {
      showControls = !showControls;
    });
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Widget _buildVideoPlayer() {
    return GestureDetector(
      onTap: _toggleControls,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Video
          Container(
            width: double.infinity,
            color: Colors.black,
            child: isReady
                ? AspectRatio(
                    aspectRatio: isFullscreen
                        ? MediaQuery.of(context).size.aspectRatio
                        : playerController.value.aspectRatio,
                    child: VideoPlayer(playerController),
                  )
                : const SizedBox(
                    height: 220,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
          ),

          // Overlay controls
          if (isReady && showControls)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                    stops: const [0.0, 0.3, 0.6, 1.0],
                  ),
                ),
              ),
            ),

          // Play/Pause button tengah
          if (isReady && showControls)
            GestureDetector(
              onTap: () {
                setState(() {
                  if (playerController.value.isPlaying) {
                    playerController.pause();
                  } else {
                    playerController.play();
                  }
                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  playerController.value.isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),

          // Bottom controls: progress + fullscreen
          if (isReady && showControls)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: Column(
                  children: [
                    // Progress bar
                    VideoProgressIndicator(
                      playerController,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Color(0xFF8B6347),
                        bufferedColor: Color(0xFFD7B899),
                        backgroundColor: Colors.white38,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          _formatDuration(playerController.value.position),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                        const Text(
                          " / ",
                          style: TextStyle(color: Colors.white54, fontSize: 11),
                        ),
                        Text(
                          _formatDuration(playerController.value.duration),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                        const Spacer(),
                        // Tombol fullscreen
                        GestureDetector(
                          onTap: () {
                            if (isFullscreen) {
                              _exitFullscreen();
                            } else {
                              _enterFullscreen();
                            }
                          },
                          child: Icon(
                            isFullscreen
                                ? Icons.fullscreen_exit_rounded
                                : Icons.fullscreen_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final video = Get.arguments as Map<String, dynamic>;

    // Mode fullscreen: tampil hitam semua, video mengisi layar
    if (isFullscreen) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: _buildVideoPlayer(),
                ),
              ),
              // Tombol back di fullscreen
              if (showControls)
                Positioned(
                  top: 8,
                  left: 8,
                  child: GestureDetector(
                    onTap: _exitFullscreen,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    // Mode normal
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
            // Video player normal
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              child: _buildVideoPlayer(),
            ),

            // Konten
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
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

                  Text(
                    video["title"] ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3E2723),
                      height: 1.35,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    video["description"] ??
                        "Belajar anyaman bambu menggunakan tutorial video.",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8B6347),
                      height: 1.65,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Divider(color: Color(0xFFF0E6DD), thickness: 1),

                  const SizedBox(height: 20),

                  // Computer Vision Card
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                            icon: const Icon(Icons.camera_alt_rounded, size: 20),
                            label: const Text(
                              "Mulai Deteksi",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
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
  }
}