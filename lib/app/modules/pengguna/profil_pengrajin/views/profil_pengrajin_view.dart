import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/providers/api_provider.dart';

import '../../../../routes/app_pages.dart';

class ProfilPengrajinView extends StatelessWidget {
  const ProfilPengrajinView({super.key});

  @override
  Widget build(BuildContext context) {
    final pengrajin = Get.arguments;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5F1),

        elevation: 0,

        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Get.back();
          },

          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF3E2723),
            size: 20,
          ),
        ),

        title: const Text(
          "Profil Pengrajin",

          style: TextStyle(
            color: Color(0xFF3E2723),

            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child:
                        pengrajin["photo"] != null &&
                            pengrajin["photo"].toString().isNotEmpty
                        ? Image.network(
                            "http://10.223.117.75:3000/uploads/${pengrajin['photo']}",
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _fotoDefault(),
                          )
                        : _fotoDefault(),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pengrajin["name"] ?? "-",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 20,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              "${pengrajin["rating"] ?? 0}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(
                                Routes.PILIH_KELAS,
                                arguments: pengrajin,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5A3116),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Pesan Kelas",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // INFORMASI
            _buildInfoCard(
              title: "Pengalaman",
              content: pengrajin["pengalaman"] ?? "-",
            ),

            const SizedBox(height: 18),

            _buildInfoCard(
              title: "Deskripsi",
              content: pengrajin["deskripsi"] ?? "-",
            ),

            const SizedBox(height: 18),

            _buildInfoCard(
              title: "Alamat",
              content: pengrajin["alamat"] ?? "-",
            ),

            const SizedBox(height: 18),

            _buildInfoCard(
              title: "Nomor Telpon",
              content: pengrajin["noTelpon"] ?? "-",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),

            blurRadius: 8,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E2723),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.brown,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fotoDefault() {
    return Container(
      width: 120,

      height: 120,

      decoration: const BoxDecoration(
        color: Color(0xFFF3EAE0),

        shape: BoxShape.circle,
      ),

      child: const Icon(Icons.person, size: 60, color: Color(0xFF5A3116)),
    );
  }
}
