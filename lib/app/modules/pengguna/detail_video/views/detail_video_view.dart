import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../data/services/pengguna_service.dart';
import '../../../../global_widgets/custom_navbar.dart';

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
      if (!mounted) return;

      setState(() {
        isReady = true;
      });
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

      if (mounted) {
        setState(() {});
      }
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
    final m = d.inMinutes.remainder(60).toString().padLeft(2, "0");

    final s = d.inSeconds.remainder(60).toString().padLeft(2, "0");

    return "$m:$s";
  }

  Widget _buildVideoPlayer() {
    return GestureDetector(
      onTap: _toggleControls,
      child: Stack(
        alignment: Alignment.center,
        children: [
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
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
          ),

          if (isReady && showControls)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(.35),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(.60),
                    ],
                  ),
                ),
              ),
            ),

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
                width: MediaQuery.of(context).size.width * 0.16,
                height: MediaQuery.of(context).size.width * 0.16,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.55),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  playerController.value.isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.09,
                ),
              ),
            ),
          if (isReady && showControls)
            Positioned(
              left: 12,
              right: 12,
              bottom: 10,
              child: Column(
                children: [
                  VideoProgressIndicator(
                    playerController,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Color(0xFF8B6347),
                      bufferedColor: Color(0xFFD7B899),
                      backgroundColor: Colors.white38,
                    ),
                  ),

                  const SizedBox(height: 8),

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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final video = Get.arguments as Map<String, dynamic>;
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    if (isFullscreen) {
      return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: const CustomNavbar(currentIndex: -1),
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

              if (showControls)
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: _exitFullscreen,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
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

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.02, w * 0.05, h * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        splashRadius: 22,
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: const Color(0xFF5A3116),
                          size: w * 0.055,
                        ),
                      ),
                    ),

                    Transform.translate(
                      offset: Offset(0, h * 0.003),
                      child: Text(
                        "Video Tutorial",
                        style: TextStyle(
                          fontSize: w * 0.065,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3E2723),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.004),
              Center(
                child: SizedBox(
                  width: w * .82,
                  child: Text(
                    "Pelajari teknik anyaman melalui video interaktif",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * 0.02),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _buildVideoPlayer(),
              ),

              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.045),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(.08),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5ECE3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Tutorial",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5A3116),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      video["title"] ?? "",
                      style: TextStyle(
                        fontSize: w * 0.052,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      video["description"] ??
                          "Pelajari teknik anyaman bambu melalui video tutorial.",
                      style: TextStyle(
                        fontSize: w * 0.036,
                        color: Colors.grey,
                        height: 1.7,
                      ),
                    ),

                    const SizedBox(height: 22),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
