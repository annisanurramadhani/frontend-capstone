import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GestureService {
  late WebSocketChannel _channel;

  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse("ws://192.168.1.7:8765"),
    );

    debugPrint("Gesture Connected");
  }

  void send(String base64Image) {
    _channel.sink.add(base64Image);
  }

  Stream<String> get stream {
    return _channel.stream.cast<String>();
  }

  void disconnect() {
    _channel.sink.close();

    debugPrint("Gesture Disconnected");
  }
}