// custom_navbar.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class CustomNavbar extends StatelessWidget {

  final int currentIndex;

  const CustomNavbar({
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
            title: "Jadwal",
            index: 0,
            route: Routes.JADWAL_SAYA,
          ),

          navItem(
            icon: Icons.home_outlined,
            title: "Beranda",
            index: 1,
            route: Routes.HALAMAN_UTAMA,
          ),

          navItem(
            icon: Icons.person_outline,
            title: "Profil",
            index: 2,
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

    final bool isActive =
        currentIndex == index;

    return InkWell(

      onTap: () {

        if (!isActive) {

          Get.offAllNamed(route);
        }
      },

      borderRadius:
          BorderRadius.circular(20),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            size: 30,
            color: isActive
                ? const Color(0xFF5A3116)
                : Colors.grey,
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: isActive
                  ? const Color(0xFF5A3116)
                  : Colors.grey,
            ),
          ),

        ],
      ),
    );
  }
}