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

          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E2723)),
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
            // CARD PROFILE
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(30),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),

                    blurRadius: 10,

                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                children: [
                  // FOTO
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),

                    child:
                        pengrajin["photo"] != null &&
                            pengrajin["photo"].toString().isNotEmpty
                        ? Image.network(
                            "${ApiProvider.baseUrl}/uploads/${pengrajin["photo"]}",

                            width: 120,

                            height: 120,

                            fit: BoxFit.cover,

                            errorBuilder: (context, error, stackTrace) {
                              return _fotoDefault();
                            },
                          )
                        : _fotoDefault(),
                  ),

                  const SizedBox(height: 20),

                  // NAMA
                  Text(
                    pengrajin["name"] ?? "-",

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: size.width * 0.07,

                      fontWeight: FontWeight.bold,

                      color: const Color(0xFF3E2723),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // RATING
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,

                      vertical: 10,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3D6),

                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        const Icon(Icons.star, color: Colors.amber),

                        const SizedBox(width: 6),

                        Text(
                          "${pengrajin["rating"]}",

                          style: const TextStyle(fontWeight: FontWeight.bold),
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

              icon: Icons.work_outline,

              content: pengrajin["pengalaman"] ?? "-",
            ),

            const SizedBox(height: 18),

            _buildInfoCard(
              title: "Deskripsi",

              icon: Icons.description_outlined,

              content: pengrajin["deskripsi"] ?? "-",
            ),

            const SizedBox(height: 18),

            _buildInfoCard(
              title: "Alamat",

              icon: Icons.location_on_outlined,

              content: pengrajin["alamat"] ?? "-",
            ),

            const SizedBox(height: 18),

            _buildInfoCard(
              title: "Nomor Telpon",

              icon: Icons.phone_outlined,

              content: pengrajin["noTelpon"] ?? "-",
            ),

            const SizedBox(height: 30),

            // BUTTON PESAN
            SizedBox(
              width: double.infinity,

              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed(Routes.PILIH_KELAS, arguments: pengrajin);
                },

                icon: const Icon(Icons.school_outlined),

                label: const Text("Pesan Pelatihan"),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A3116),

                  foregroundColor: Colors.white,

                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required String content,
  }) {
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
          Row(
            children: [
              Icon(icon, color: const Color(0xFF5A3116)),

              const SizedBox(width: 10),

              Text(
                title,

                style: const TextStyle(
                  fontSize: 18,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            content,

            style: const TextStyle(
              color: Colors.brown,

              height: 1.7,

              fontSize: 15,
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
