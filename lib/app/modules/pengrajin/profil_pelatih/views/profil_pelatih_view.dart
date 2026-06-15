import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profil_pelatih_controller.dart';
import '../../../../global_widgets/navbar_pengrajin.dart';

class ProfilPelatihView extends GetView<ProfilPelatihController> {
  const ProfilPelatihView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Profil",
          style: TextStyle(
            color: Color(0xFF5A3116),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFF5F5F5),

                backgroundImage: controller.foto.value.isNotEmpty
                    ? NetworkImage(controller.foto.value)
                    : null,

                child: controller.foto.value.isEmpty
                    ? const Icon(Icons.person, size: 60, color: Colors.grey)
                    : null,
              ),

              const SizedBox(height: 20),

              Text(
                controller.nama.value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A3116),
                ),
              ),

              const SizedBox(height: 30),

              buildItem(
                icon: Icons.email_outlined,
                title: "Email",
                value: controller.email.value,
              ),

              buildItem(
                icon: Icons.phone_outlined,
                title: "Nomor HP",
                value: controller.noHp.value,
              ),

              buildItem(
                icon: Icons.location_on_outlined,
                title: "Alamat",
                value: controller.alamat.value,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: controller.editProfil,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A3116),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: const Text(
                    "Edit Profil",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: OutlinedButton(
                  onPressed: controller.logout,

                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      }),

      bottomNavigationBar: const NavbarPengrajin(currentIndex: 2),
    );
  }

  Widget buildItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF5A3116)),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
