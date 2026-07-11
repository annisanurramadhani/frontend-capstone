import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Path import menggunakan ../../ agar bisa keluar dari data/services
import '../../modules/pengguna/notifikasi/controllers/notifikasi_controller.dart'; 

class SocketService {
  static late IO.Socket socket;

  static void connect() {
    socket = IO.io(
      "https://anyam.onrender.com",
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

    // 1. MATIKAN listener lama agar tidak terjadi duplikasi trigger (Sangat Penting!)
    socket.off("notifikasi");

    // 2. DAFTARKAN listener baru
    socket.on(
      "notifikasi",
      (data) {
        print(data);

        // 3. CEK agar snackbar tidak menimpa snackbar yang sedang berjalan
        if (!Get.isSnackbarOpen) {
          // Desain Snackbar yang kontras dan jelas (tidak transparan)
          Get.snackbar(
            data["judul"] ?? "Notifikasi Baru",
            data["pesan"] ?? "Ada pembaruan untuk pesanan Anda",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.black87,
            margin: const EdgeInsets.all(14),
            borderRadius: 12,
            icon: const Icon(Icons.notifications_active, color: Color(0xFF5A3116), size: 28),
            boxShadows: [
              const BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
            ],
            duration: const Duration(seconds: 4),
          );
        }

        // Auto-refresh daftar riwayat notifikasi jika halaman sedang dibuka
        if (Get.isRegistered<NotifikasiController>()) {
          Get.find<NotifikasiController>().getNotifikasi();
        }
      },
    );
  }

  static void disconnect() {
    if (socket.connected) {
      socket.disconnect();
    }
  }
}