import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static late IO.Socket socket;

  static void connect() {
    socket = IO.io(
      "https://armory-undertone-pamperer.ngrok-free.dev",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setExtraHeaders({'ngrok-skip-browser-warning': '69420'})
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