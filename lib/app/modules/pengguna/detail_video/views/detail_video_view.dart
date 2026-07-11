import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controllers/detail_video_controller.dart';

class DetailVideoView extends GetView<DetailVideoController> {
  const DetailVideoView({super.key});

  String formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, "0");
    final s = d.inSeconds.remainder(60).toString().padLeft(2, "0");

    return "$m:$s";
  }

  Widget buildVideoPlayer(BuildContext context) {
    return GetBuilder<DetailVideoController>(
      builder: (_) {
        return GestureDetector(
          onTap: controller.toggleControls,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                color: Colors.black,
                child: controller.isReady.value && controller.playerController != null
                    ? AspectRatio(
                        aspectRatio: controller.isFullscreen.value
                            ? MediaQuery.of(context).size.aspectRatio
                            : controller.playerController!.value.aspectRatio,
                        child: VideoPlayer(controller.playerController!),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
              ),

              // if (controller.isCameraReady.value && controller.cameraController != null)
              //   Positioned(
              //     top: 12,
              //     right: 12,
              //     child: Container(
              //       width: 110,
              //       height: 150,
              //       decoration: BoxDecoration(
              //         color: Colors.black,
              //         borderRadius: BorderRadius.circular(12),
              //         border: Border.all(color: Colors.white, width: 2),
              //       ),
              //       clipBehavior: Clip.antiAlias,
              //       child: CameraPreview(controller.cameraController!),
              //     ),
              //   ),

              if (controller.isReady.value && controller.showControls.value)
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

              if (controller.isReady.value && controller.showControls.value && controller.playerController != null)
                GestureDetector(
                  onTap: controller.playPause,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .16,
                    height: MediaQuery.of(context).size.width * .16,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.55),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      controller.playerController!.value.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * .09,
                    ),
                  ),
                ),
              if (controller.isReady.value && controller.showControls.value && controller.playerController != null)
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 10,
                  child: Column(
                    children: [
                      VideoProgressIndicator(
                        controller.playerController!,
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
                            formatDuration(
                              controller.playerController!.value.position,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),

                          const Text(
                            " / ",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),

                          Text(
                            formatDuration(
                              controller.playerController!.value.duration,
                            ),
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),

                          const Spacer(),

                          GestureDetector(
                            onTap: () {
                              if (controller.isFullscreen.value) {
                                SystemChrome.setEnabledSystemUIMode(
                                  SystemUiMode.manual,
                                  overlays: SystemUiOverlay.values,
                                );

                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.portraitUp,
                                ]);

                                controller.exitFullscreen();
                              } else {
                                SystemChrome.setEnabledSystemUIMode(
                                  SystemUiMode.immersiveSticky,
                                );

                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.landscapeLeft,
                                  DeviceOrientation.landscapeRight,
                                ]);

                                controller.enterFullscreen();
                              }
                            },
                            child: Icon(
                              controller.isFullscreen.value
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final w = size.width;
    final h = size.height;

    if (controller.isFullscreen.value) {
      return PopScope(
        canPop: false, // Perbaikan pop scope
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          );

          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          controller.exitFullscreen();
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: buildVideoPlayer(context),
                  ),
                ),

                if (controller.showControls.value)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        SystemChrome.setEnabledSystemUIMode(
                          SystemUiMode.manual,
                          overlays: SystemUiOverlay.values,
                        );

                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                        ]);

                        controller.exitFullscreen();
                      },
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
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(w * .05, h * .02, w * .05, h * .03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * .065,
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
                          size: w * .055,
                        ),
                      ),
                    ),

                    Transform.translate(
                      offset: Offset(0, h * .003),
                      child: Text(
                        "Video Tutorial",
                        style: TextStyle(
                          fontSize: w * .065,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3E2723),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * .004),

              Center(
                child: SizedBox(
                  width: w * .82,
                  child: Text(
                    "Pelajari teknik anyaman melalui video interaktif",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w * .035,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * .02),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: buildVideoPlayer(context),
              ),

              const SizedBox(height: 22),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * .045),
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
                      controller.video["title"] ?? "",
                      style: TextStyle(
                        fontSize: w * .052,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3E2723),
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      controller.video["description"] ??
                          "Pelajari teknik anyaman bambu melalui video tutorial.",
                      style: TextStyle(
                        fontSize: w * .036,
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