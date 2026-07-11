import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../data/services/pengguna_service.dart';

class DetailVideoController extends GetxController {
  late VideoPlayerController playerController;

  late CameraController cameraController;

  late CameraDescription frontCamera;

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
    // PERBAIKAN: Validasi URL Video dengan aman
    final String videoUrl = rawVideoUrl.startsWith("http")
        ? rawVideoUrl
        : "${ApiProvider.baseUrl}${rawVideoUrl.startsWith('/') ? '' : '/'}$rawVideoUrl";

    try {
      playerController = VideoPlayerController.networkUrl(
        Uri.parse(Uri.encodeFull(videoUrl)),
      );
      await playerController.initialize();
      isReady.value = true;
    } catch (e) {
      debugPrint("Gagal menginisialisasi Video Player: $e");
    }

    playerController.addListener(() async {
      update();
      if (sudahKirimAktivitas) return;
      if (playerController.value.position.inSeconds >= 5) {
        sudahKirimAktivitas = true;
        try {
          await PenggunaService.createAktivitasVideo(video["id"]);
        } catch (_) {}
      }
    });

    await initCamera(); // Sekarang aman karena ada try-catch
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
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await cameraController.initialize();
      isCameraReady.value = true;
      debugPrint("Camera Ready");
      update();
    } catch (e) {
      // PERBAIKAN: Cegah aplikasi crash jika permission kamera ditolak
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
    if (!isCameraReady.value) return;

    await cameraController.startImageStream(processCameraImage);

    debugPrint("Gesture Detection Started");
  }

  Future<void> processCameraImage(CameraImage image) async {
    debugPrint("Frame");

    if (isDetecting) return;

    isDetecting = true;

    try {
      hands = handLandmarker.detect(image, frontCamera.sensorOrientation);
      debugPrint("Hands: ${hands.length}");

      detectGesture();
    } catch (e) {
      debugPrint("Gesture Error : $e");
    } finally {
      isDetecting = false;
    }
  }

  // void detectGesture() {
  //   if (hands.isEmpty) return;

  //   final hand = hands.first.landmarks;
  //   debugPrint("Palm=${isOpenPalm(hand)} Thumb=${isThumbUp(hand)}");

  //   if (isThumbUp(hand)) {
  //     if (!playerController.value.isPlaying) {
  //       playerController.play();
  //       debugPrint("PLAY");
  //     }
  //   } else if (isOpenPalm(hand)) {
  //     if (playerController.value.isPlaying) {
  //       playerController.pause();
  //       debugPrint("PAUSE");
  //     }
  //   }
  // }

  void detectGesture() {
    if (hands.isEmpty) return;

    final hand = hands.first.landmarks;

    final play = isThumbUp(hand);
    final pause = isOpenPalm(hand);

    debugPrint("PLAY=$play PAUSE=$pause");

    if (play) {
      if (!playerController.value.isPlaying) {
        playerController.play();
        debugPrint("PLAY");
      }
    } else if (pause) {
      if (playerController.value.isPlaying) {
        playerController.pause();
        debugPrint("PAUSE");
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
    if (playerController.value.isPlaying) {
      playerController.pause();
    } else {
      playerController.play();
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
    if (cameraController.value.isInitialized) {
      if (cameraController.value.isStreamingImages) {
        cameraController.stopImageStream();
      }

      cameraController.dispose();
    }

    handLandmarker.dispose();

    playerController.dispose();

    super.onClose();
  }
}
