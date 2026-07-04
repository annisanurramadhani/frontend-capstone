import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static late IO.Socket socket;

  static void connect() {
    socket = IO.io(
      "http://10.62.136.201:3000",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    socket.onConnect((_) {
      print("SOCKET CONNECTED");
    });

    socket.onDisconnect((_) {
      print("SOCKET DISCONNECTED");
    });

    socket.on(
      "notifikasi",
      (data) {
        print(data);

        Get.snackbar(
          data["judul"],
          data["pesan"],
          snackPosition: SnackPosition.TOP,
        );
      },
    );
  }

  static void disconnect() {
    socket.disconnect();
  }
}