import 'package:camera/camera.dart';
import 'package:hand_landmarker/hand_landmarker.dart';

class HandLandmarkerService {
  late HandLandmarkerPlugin _plugin;

  void initialize() {
    _plugin = HandLandmarkerPlugin.create(
      numHands: 1,
      minHandDetectionConfidence: 0.7,
      delegate: HandLandmarkerDelegate.gpu,
    );
  }

  List<Hand> detect(
    CameraImage image,
    int sensorOrientation,
  ) {
    return _plugin.detect(
      image,
      sensorOrientation,
    );
  }

  void dispose() {
    _plugin.dispose();
  }
}