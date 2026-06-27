import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;

  const CustomNavbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navItem(
            icon: Icons.local_shipping_outlined,
            title: "Pesanan",
            index: 0,
            route: Routes.LIHAT_PESANAN,
          ),

          navItem(
            icon: Icons.calendar_month_outlined,
            title: "Jadwal",
            index: 1,
            route: Routes.JADWAL_SAYA,
          ),

          navItem(
            icon: Icons.home_rounded,
            title: "Beranda",
            index: 2,
            route: Routes.HALAMAN_UTAMA,
          ),

          navItem(
            icon: Icons.workspace_premium_outlined,
            title: "Sertifikat",
            index: 3,
            route: Routes.SERTIFIKAT,
          ),

          navItem(
            icon: Icons.person_outline,
            title: "Profil",
            index: 4,
            route: Routes.PROFIL,
          ),
        ],
      ),
    );
  }

  Widget navItem({
    required IconData icon,
    required String title,
    required int index,
    required String route,
  }) {
    final bool isActive = currentIndex != -1 && currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          if (!isActive) {
            Get.offAllNamed(route);
          }
        },
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 27,
                color: isActive ? const Color(0xFF5A3116) : Colors.grey,
              ),

              const SizedBox(height: 4),

              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? const Color(0xFF5A3116) : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
