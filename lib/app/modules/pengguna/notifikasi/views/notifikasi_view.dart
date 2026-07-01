import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../global_widgets/custom_navbar.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/notifikasi_controller.dart';

String _formatWaktu(String? createdAtRaw) {
  if (createdAtRaw == null || createdAtRaw.isEmpty) return "-";

  try {
    final date = DateTime.parse(createdAtRaw);
    return DateFormat("d MMM yyyy, HH:mm").format(date);
  } catch (_) {
    return "-";
  }
}

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),

      bottomNavigationBar: const CustomNavbar(currentIndex: -1),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF5A3116)),
            );
          }

          if (controller.notifikasiList.isEmpty) {
            return Column(
              children: [
                const SizedBox(height: 16),

                SizedBox(
                  height: 56,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.HALAMAN_UTAMA);
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          splashRadius: 22,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF5A3116),
                            size: 22,
                          ),
                        ),
                      ),

                      const Center(
                        child: Text(
                          "Notifikasi",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                const Center(
                  child: Text(
                    "Semua pemberitahuan Anda",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),

                const Spacer(),

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EAE0),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    size: 48,
                    color: Color(0xFF5A3116),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Belum ada notifikasi",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),

                const SizedBox(height: 8),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Semua informasi mengenai pembayaran, pelatihan, dan aktivitas akun akan muncul di halaman ini.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8B6347),
                      height: 1.5,
                    ),
                  ),
                ),

                const Spacer(),
              ],
            );
          }

          return Column(
            children: [
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 56,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.HALAMAN_UTAMA);
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          splashRadius: 22,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF5A3116),
                            size: 22,
                          ),
                        ),
                      ),

                      const Center(
                        child: Text(
                          "Notifikasi",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 2),

              const Center(
                child: Text(
                  "Semua pemberitahuan Anda",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 10),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.notifikasiList.length,
                  itemBuilder: (context, index) {
                    final item = controller.notifikasiList[index];

                    final bool isRead = item["dibaca"] == true;

                    return _NotifCard(
                      judul: item["judul"] ?? "",
                      pesan: item["pesan"] ?? "",
                      waktu: _formatWaktu(item["createdAt"]),
                      isRead: isRead,
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

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
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 110,
            decoration: BoxDecoration(
              color: isRead ? Colors.transparent : const Color(0xFF5A3116),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: isRead
                          ? const Color(0xFFF3EAE0)
                          : const Color(0xFF5A3116),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_rounded,
                      color: isRead ? const Color(0xFF8B6347) : Colors.white,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 14),

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
                                  fontSize: 16,
                                  fontWeight: isRead
                                      ? FontWeight.w600
                                      : FontWeight.bold,
                                  color: const Color(0xFF3E2723),
                                ),
                              ),
                            ),

                            if (!isRead)
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF5A3116),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        Text(
                          pesan,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8B6347),
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            const Icon(
                              Icons.schedule_rounded,
                              size: 15,
                              color: Color(0xFFB08060),
                            ),

                            const SizedBox(width: 6),

                            Text(
                              waktu,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFFB08060),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}