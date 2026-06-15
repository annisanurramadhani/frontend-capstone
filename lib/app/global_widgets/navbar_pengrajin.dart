import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class NavbarPengrajin extends StatelessWidget {

  final int currentIndex;

  const NavbarPengrajin({
    super.key,
    required this.currentIndex,
  });

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
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,

        children: [

          navItem(
            icon: Icons.calendar_month_outlined,
            title: "Kelas",
            index: 0,
            route: Routes.KELAS_SAYA,
          ),

          navItem(
            icon: Icons.home_outlined,
            title: "Beranda",
            index: 1,
            route: Routes.HALAMAN_PENGRAJIN,
          ),

          navItem(
            icon: Icons.person_outline,
            title: "Profil",
            index: 2,
            route: Routes.PROFIL_PELATIH,
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

    final isActive =
        currentIndex == index;

    return InkWell(

      onTap: () {

        if (!isActive) {
          Get.offAllNamed(route);
        }
      },

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            size: 28,
            color: isActive
                ? const Color(0xFF5A3116)
                : Colors.grey,
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: TextStyle(
              color: isActive
                  ? const Color(0xFF5A3116)
                  : Colors.grey,
              fontWeight: isActive
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),

        ],
      ),
    );
  }
}