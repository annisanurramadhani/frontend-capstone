import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../data/services/pengguna_service.dart';

class DetailVideoController extends GetxController {
  // PERBAIKAN: Mengubah "late" menjadi nullable (?) agar tidak crash saat try-catch gagal
  VideoPlayerController? playerController;
  CameraController? cameraController;
  CameraDescription? frontCamera;

  late HandLandmarkerPlugin handLandmarker;

  final RxMap<String, dynamic> video = <String, dynamic>{}.obs;

  final RxBool isReady = false.obs;
  final RxBool isCameraReady = false.obs;
  final RxBool isFullscreen = false.obs;
  final RxBool showControls = true.obs;

  bool sudahKirimAktivitas = false;
  bool isDetecting = false;

  List<Hand> hands = [];

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    debugPrint("Initialize");
    video.value = Get.arguments;

    final String rawVideoUrl = video["videoUrl"] ?? "";

    // 1. Tentukan URL dasar
    String videoUrl = rawVideoUrl.startsWith("http")
        ? rawVideoUrl
        : "${ApiProvider.baseUrl}${rawVideoUrl.startsWith('/') ? '' : '/'}$rawVideoUrl";

    // 2. Paksa HTTPS
    videoUrl = videoUrl.replaceFirst("http://", "https://");

    // 3. 💥 PERBAIKAN FORMAT & OPTIMASI STREAMING
    if (videoUrl.contains("cloudinary.com/video/upload/")) {
      
      // A. Tambahkan kompresi otomatis untuk Mobile (q_auto,vc_auto)
      // Ini akan membuat video 50MB menjadi sekitar 5MB saja tanpa merusak visual!
      videoUrl = videoUrl.replaceFirst(
          "upload/", "upload/q_auto,vc_auto/");

      // B. Pastikan berujung .mp4
      int dotIndex = videoUrl.lastIndexOf(".");
      if (dotIndex != -1) {
        videoUrl = "${videoUrl.substring(0, dotIndex)}.mp4";
      }
    }

    try {
      // 4. PERBAIKAN URI: Gunakan Uri.decodeFull sebelum encode agar %20 tidak dobel menjadi %2520
      String safeUrl = Uri.encodeFull(Uri.decodeFull(videoUrl));

      playerController = VideoPlayerController.networkUrl(
        Uri.parse(safeUrl),
      );
      await playerController!.initialize();
      isReady.value = true;
    } catch (e) {
      debugPrint("Gagal menginisialisasi Video Player: $e");
    }

    playerController?.addListener(() async {
      update();
      if (sudahKirimAktivitas) return;
      if (playerController!.value.isInitialized && playerController!.value.position.inSeconds >= 5) {
        sudahKirimAktivitas = true;
        try {
          await PenggunaService.createAktivitasVideo(video["id"]);
        } catch (_) {}
      }
    });

    await initCamera();
    initHandLandmarker();
    await startDetection();

    if (!isClosed) {
      update();
    }
  }

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera!,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await cameraController!.initialize();
      isCameraReady.value = true;
      debugPrint("Camera Ready");
      update();
    } catch (e) {
      debugPrint("Gagal menginisialisasi kamera (Mungkin izin ditolak): $e");
    }
  }

  void initHandLandmarker() {
    handLandmarker = HandLandmarkerPlugin.create(
      numHands: 1,
      minHandDetectionConfidence: 0.7,
      delegate: HandLandmarkerDelegate.cpu,
    );

    debugPrint("HandLandmarker Ready");
  }

  Future<void> startDetection() async {
    // Pastikan controller tidak null sebelum memulai stream
    if (!isCameraReady.value || cameraController == null) return;

    await cameraController!.startImageStream(processCameraImage);
    debugPrint("Gesture Detection Started");
  }

  Future<void> processCameraImage(CameraImage image) async {
    if (isDetecting || frontCamera == null) return;

    isDetecting = true;

    try {
      hands = handLandmarker.detect(image, frontCamera!.sensorOrientation);
      detectGesture();
    } catch (e) {
      debugPrint("Gesture Error : $e");
    } finally {
      isDetecting = false;
    }
  }

  void detectGesture() {
    // PERBAIKAN: Cegah Computer Vision memutar video jika video BELUM SIAP (isReady == false)
    if (hands.isEmpty || playerController == null || !isReady.value) return;

    final hand = hands.first.landmarks;

    final play = isThumbUp(hand);
    final pause = isOpenPalm(hand);

    if (play) {
      if (!playerController!.value.isPlaying) {
        playerController!.play();
        debugPrint("PLAY VIA GESTURE");
      }
    } else if (pause) {
      if (playerController!.value.isPlaying) {
        playerController!.pause();
        debugPrint("PAUSE VIA GESTURE");
      }
    }
  }

  double distance(Landmark a, Landmark b) {
    final dx = a.x - b.x;
    final dy = a.y - b.y;
    return dx * dx + dy * dy;
  }

  bool fingerOpen(List<Landmark> hand, int tip) {
    final wrist = hand[0];
    final d = distance(hand[tip], wrist);
    return d > 0.08;
  }

  bool isOpenPalm(List<Landmark> hand) {
    final thumb = fingerOpen(hand, 4);
    final index = fingerOpen(hand, 8);
    final middle = fingerOpen(hand, 12);
    final ring = fingerOpen(hand, 16);
    final pinky = fingerOpen(hand, 20);

    return thumb && index && middle && ring && pinky;
  }

  bool isThumbUp(List<Landmark> hand) {
    final thumb = fingerOpen(hand, 4);
    final index = !fingerOpen(hand, 8);
    final middle = !fingerOpen(hand, 12);
    final ring = !fingerOpen(hand, 16);
    final pinky = !fingerOpen(hand, 20);

    return thumb && index && middle && ring && pinky;
  }

  void playPause() {
    if (playerController == null) return;

    if (playerController!.value.isPlaying) {
      playerController!.pause();
    } else {
      playerController!.play();
    }
    update();
  }

  void enterFullscreen() {
    isFullscreen.value = true;
    update();
  }

  void exitFullscreen() {
    isFullscreen.value = false;
    update();
  }

  void toggleControls() {
    showControls.value = !showControls.value;
    update();
  }

  @override
  void onClose() {
    // PERBAIKAN: Pengecekan aman saat membuang (dispose) memory kamera
    if (cameraController != null && cameraController!.value.isInitialized) {
      if (cameraController!.value.isStreamingImages) {
        cameraController!.stopImageStream();
      }
      cameraController!.dispose();
    }

    handLandmarker.dispose();
    playerController?.dispose();

    super.onClose();
  }
}
