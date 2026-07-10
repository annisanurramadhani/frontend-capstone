import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/providers/api_provider.dart';
import '../../../../routes/app_pages.dart';
import '../../../../global_widgets/custom_navbar.dart';

class ProfilPengrajinView extends StatelessWidget {
  const ProfilPengrajinView({super.key});

  @override
  Widget build(BuildContext context) {
    final pengrajin = Get.arguments;
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      bottomNavigationBar: const CustomNavbar(currentIndex: -1),

      backgroundColor: const Color(0xFFFAF6F1),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Column(
            children: [
              SizedBox(height: h * 0.02),
              SizedBox(
                height: 56,
                child: Row(
                  children: [
                    SizedBox(
                      width: 48,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 22,
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: w * 0.055,
                          color: const Color(0xFF5A3116),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "Profil Pengrajin",
                          style: TextStyle(
                            fontSize: w * 0.065,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),
              ),

              SizedBox(height: h * 0.004),

              Center(
                child: Text(
                  "Informasi lengkap mengenai pengrajin",
                  style: TextStyle(fontSize: w * 0.034, color: Colors.grey),
                ),
              ),

              SizedBox(height: h * 0.02),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.06),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.06),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipOval(
                      child:
                          pengrajin["photo"] != null &&
                                  pengrajin["photo"].toString().isNotEmpty
                              ? Image.network(
                                  pengrajin["photo"].toString().startsWith("http")
                                      ? pengrajin["photo"]
                                      : "${ApiProvider.baseUrl}${pengrajin["photo"]}",
                                  width: w * 0.28,
                                  height: w * 0.28,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) {
                                    return Container(
                                      width: 110,
                                      height: 110,
                                      color: Color(0xFFF3EAE0),
                                      child: Icon(
                                        Icons.person,
                                        size: w * 0.14,
                                        color: Color(0xFF5A3116),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  width: 110,
                                  height: 110,
                                  color: const Color(0xFFF3EAE0),
                                  child: const Icon(
                                    Icons.person,
                                    size: 55,
                                    color: Color(0xFF5A3116),
                                  ),
                                ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      pengrajin["name"] ?? "-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.055,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.035,
                            vertical: h * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3EAE0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "${pengrajin["rating"] ?? 0}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3EAE0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.work_outline,
                                color: Color(0xFF5A3116),
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                pengrajin["pengalaman"] ?? "-",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: h * 0.06,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.toNamed(Routes.PILIH_KELAS, arguments: pengrajin);
                        },
                        label: Text(
                          "Pesan Kelas",
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5A3116),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.04),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tentang Pengrajin",
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.06),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  pengrajin["deskripsi"] ?? "-",
                  style: TextStyle(
                    fontSize: w * 0.036,
                    color: Color(0xFF3E2723),
                    height: 1.7,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Informasi",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      icon: Icons.location_on_outlined,
                      title: "Alamat",
                      content: pengrajin["alamat"] ?? "-",
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  Expanded(
                    child: _buildInfoCard(
                      icon: Icons.phone_outlined,
                      title: "Kontak",
                      content: pengrajin["noTelpon"] ?? "-",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFF3EAE0),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF5A3116), size: 20),
          ),

          const SizedBox(height: 14),

          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E2723),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}