import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../routes/app_pages.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../global_widgets/custom_navbar.dart';
import '../../detail_video/views/detail_video_view.dart';
import '../controllers/belajar_anyaman_controller.dart';

class BelajarAnyamanView extends GetView<BelajarAnyamanController> {
  const BelajarAnyamanView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF6F1),
        bottomNavigationBar: const CustomNavbar(currentIndex: -1),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.07,
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
                            size: size.width * 0.055,
                          ),
                        ),
                      ),

                      Center(
                        child: Text(
                          "Belajar Anyaman",
                          style: TextStyle(
                            fontSize: size.width * 0.065,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.004),

                Center(
                  child: SizedBox(
                    width: size.width * 0.82,
                    child: Text(
                      "Pelajari berbagai teknik anyaman bambu melalui video tutorial interaktif",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        color: Colors.grey,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(.06),
                        blurRadius: 8,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari video tutorial...",
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 22,
                        color: Color(0xFF5A3116),
                      ),
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                const SizedBox(height: 6),

                Obx(() {
                  if (controller.isLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF5A3116),
                        ),
                      ),
                    );
                  }

                  if (controller.videos.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Center(
                        child: Text(
                          "Belum ada video tutorial.",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.videos.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return _VideoCard(video: controller.videos[index]);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final Map<String, dynamic> video;

  const _VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final thumbnail = video["thumbnail"] ?? "";

    final thumbnailUrl = thumbnail.toString().startsWith("http")
        ? thumbnail
        : "${ApiProvider.baseUrl}$thumbnail";

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          if (box.read("hideComputerVisionInfo") == true) {
            Get.toNamed(Routes.DETAIL_VIDEO, arguments: video);
            return;
          }

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => ComputerVisionSheet(video: video),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
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
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      Uri.encodeFull(thumbnailUrl),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.22,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 210,
                          color: const Color(0xFFF3EAE0),
                          child: const Icon(
                            Icons.broken_image_outlined,
                            size: 54,
                            color: Color(0xFF8B6347),
                          ),
                        );
                      },
                    ),

                    Positioned.fill(
                      child: Center(
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.45),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 3,
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

                    const SizedBox(height: 8),

                    Text(
                      video["title"] ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      video["description"] ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComputerVisionSheet extends StatefulWidget {
  final Map<String, dynamic> video;

  const ComputerVisionSheet({super.key, required this.video});

  @override
  State<ComputerVisionSheet> createState() => _ComputerVisionSheetState();
}

class _ComputerVisionSheetState extends State<ComputerVisionSheet> {
  final box = GetStorage();

  bool janganTampilkanLagi = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 55,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(50),
              ),
            ),

            const SizedBox(height: 24),

            const SizedBox(height: 28),

            const Text(
              "Computer Vision",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E2723),
              ),
            ),

            const SizedBox(height: 10),

            const SizedBox(
              width: 240,
              child: Text(
                "Mengontrol video menggunakan\ngesture tangan",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.6),
              ),
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F2EB),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.front_hand_outlined,
                          size: 40,
                          color: Color(0xFF5A3116),
                        ),

                        SizedBox(height: 12),

                        Text(
                          "Lima Jari\nTerbuka",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF3E2723),
                            height: 1.4,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          "Pause Video",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F2EB),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.thumb_up_alt_outlined,
                          size: 36,
                          color: Color(0xFF5A3116),
                        ),

                        SizedBox(height: 12),

                        Text(
                          "Jempol",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF3E2723),
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          "Lanjutkan\nVideo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF8EC),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20),

                  SizedBox(width: 8),

                  Text(
                    "Aktif Otomatis Saat Video Diputar",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            CheckboxListTile(
              value: janganTampilkanLagi,
              contentPadding: EdgeInsets.zero,
              activeColor: const Color(0xFF5A3116),
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                "Jangan tampilkan lagi",
                style: TextStyle(fontSize: 14, color: Color(0xFF3E2723)),
              ),
              onChanged: (value) {
                setState(() {
                  janganTampilkanLagi = value ?? false;
                });
              },
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  if (janganTampilkanLagi) {
                    box.write("hideComputerVisionInfo", true);
                  }

                  Navigator.pop(context);

                  Get.toNamed(Routes.DETAIL_VIDEO, arguments: widget.video);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A3116),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  "Mengerti",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
