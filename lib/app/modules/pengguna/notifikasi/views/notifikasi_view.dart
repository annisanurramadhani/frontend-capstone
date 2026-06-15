import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
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
          "Notifikasi",
          style: TextStyle(
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Obx(() {
        // ── LOADING ──────────────────────────────────────────────────
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF5A3116)),
          );
        }

        // ── KOSONG ───────────────────────────────────────────────────
        if (controller.notifikasiList.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EAE0),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.notifications_off_outlined,
                    size: 40,
                    color: Color(0xFF5A3116),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Belum ada notifikasi",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E2723),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Notifikasi akan muncul di sini",
                  style: TextStyle(fontSize: 13, color: Color(0xFF8B6347)),
                ),
              ],
            ),
          );
        }

        // ── LIST ─────────────────────────────────────────────────────
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.notifikasiList.length,
          itemBuilder: (context, index) {
            final item = controller.notifikasiList[index];
            final bool isRead = item["isRead"] == true;

            return _NotifCard(
              judul: item["judul"] ?? "",
              pesan: item["pesan"] ?? "",
              waktu: item["waktu"] ?? "",
              isRead: isRead,
            );
          },
        );
      }),
    );
  }
}

// ── NOTIF CARD ───────────────────────────────────────────────────────────────

class _NotifCard extends StatelessWidget {
  final String judul;
  final String pesan;
  final String waktu;
  final bool isRead;

  const _NotifCard({
    required this.judul,
    required this.pesan,
    required this.waktu,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : const Color(0xFFFFF8F3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isRead ? const Color(0xFFF0E6DD) : const Color(0xFFD4A574),
          width: isRead ? 1.2 : 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── ICON ─────────────────────────────────────────────────
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isRead ? const Color(0xFFF3EAE0) : const Color(0xFF5A3116),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.notifications_outlined,
              size: 22,
              color: isRead ? const Color(0xFF8B6347) : const Color(0xFFFFE0B2),
            ),
          ),

          const SizedBox(width: 12),

          // ── KONTEN ───────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        judul,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isRead
                              ? FontWeight.w500
                              : FontWeight.w700,
                          color: const Color(0xFF3E2723),
                        ),
                      ),
                    ),
                    if (!isRead)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(left: 8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF5A3116),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  pesan,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8B6347),
                    height: 1.5,
                  ),
                ),

                if (waktu.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    waktu,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFB08060),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
