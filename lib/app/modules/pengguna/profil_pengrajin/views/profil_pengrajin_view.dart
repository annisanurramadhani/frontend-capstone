// profil_pengrajin_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profil_pengrajin_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class ProfilPengrajinView extends GetView<ProfilPengrajinController> {
  const ProfilPengrajinView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // PROFIL PENGRAJIN
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.pengrajin;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: EdgeInsets.all(size.width * 0.055),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // HEADER
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.kembali,

                      icon: const Icon(
                        Icons.arrow_back_ios_new,

                        color: Color(0xFF5A3116),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "Profil Pengrajin",

                          style: TextStyle(
                            fontSize: size.width * 0.065,

                            fontWeight: FontWeight.bold,

                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),

                SizedBox(height: size.height * 0.03),

                // FOTO
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),

                  child: Image.asset(
                    data["foto"],

                    width: double.infinity,

                    height: size.height * 0.38,

                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // NAMA
                Text(
                  data["nama"],

                  style: TextStyle(
                    fontSize: size.width * 0.08,

                    fontWeight: FontWeight.bold,

                    color: const Color(0xFF3E2723),
                  ),
                ),

                SizedBox(height: 12),

                // LOKASI
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.brown),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        data["lokasi"],

                        style: TextStyle(
                          fontSize: size.width * 0.04,

                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14),

                // RATING
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange),

                    const SizedBox(width: 8),

                    Text(
                      data["rating"],

                      style: TextStyle(
                        fontSize: size.width * 0.045,

                        fontWeight: FontWeight.bold,

                        color: const Color(0xFF3E2723),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.03),

                // SPESIALIS
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Row(
                    children: [
                      const Icon(
                        Icons.workspace_premium_outlined,

                        color: Color(0xFF5A3116),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          data["spesialis"],

                          style: TextStyle(
                            fontSize: size.width * 0.04,

                            fontWeight: FontWeight.w600,

                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // STATISTIK
                Row(
                  children: [
                    Expanded(
                      child: statistikCard(
                        icon: Icons.calendar_month_outlined,

                        title: data["pengalaman"],

                        subtitle: "Pengalaman",
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: statistikCard(
                        icon: Icons.groups_outlined,

                        title: data["siswa"],

                        subtitle: "Siswa",
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.04),

                // TENTANG
                Text(
                  "Tentang",

                  style: TextStyle(
                    fontSize: size.width * 0.06,

                    fontWeight: FontWeight.bold,

                    color: const Color(0xFF3E2723),
                  ),
                ),

                SizedBox(height: 14),

                Text(
                  data["tentang"],

                  style: TextStyle(
                    fontSize: size.width * 0.04,

                    color: Colors.brown,

                    height: 1.8,
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // ULASAN
                Text(
                  "Ulasan",

                  style: TextStyle(
                    fontSize: size.width * 0.06,

                    fontWeight: FontWeight.bold,

                    color: const Color(0xFF3E2723),
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                ListView.builder(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: controller.ulasanList.length,

                  itemBuilder: (context, index) {
                    final ulasan = controller.ulasanList[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 18),

                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(24),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            ulasan["nama"],

                            style: TextStyle(
                              fontSize: size.width * 0.045,

                              fontWeight: FontWeight.bold,

                              color: const Color(0xFF3E2723),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.orange),

                              const SizedBox(width: 6),

                              Text(ulasan["rating"]),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Text(
                            ulasan["ulasan"],

                            style: TextStyle(
                              fontSize: size.width * 0.038,

                              color: Colors.brown,

                              height: 1.7,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: size.height * 0.04),

                // BUTTON
                SizedBox(
                  width: double.infinity,

                  height: 60,

                  child: ElevatedButton(
                    onPressed: controller.pesanKelas,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A3116),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    child: Text(
                      "Pesan Kelas",

                      style: TextStyle(
                        fontSize: size.width * 0.045,

                        fontWeight: FontWeight.bold,

                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget statistikCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        children: [
          Icon(icon, size: 34, color: const Color(0xFF5A3116)),

          const SizedBox(height: 14),

          Text(
            title,

            style: const TextStyle(
              fontSize: 20,

              fontWeight: FontWeight.bold,

              color: Color(0xFF3E2723),
            ),
          ),

          const SizedBox(height: 6),

          Text(subtitle, style: const TextStyle(color: Colors.brown)),
        ],
      ),
    );
  }
}
