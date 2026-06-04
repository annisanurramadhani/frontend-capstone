// daftar_pengrajin_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/daftar_pengrajin_controller.dart';
import '../../../../global_widgets/custom_navbar.dart';

class DaftarPengrajinView extends GetView<DaftarPengrajinController> {
  const DaftarPengrajinView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),

      // DAFTAR PENGRAJIN
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.055),

          child: Column(
            children: [
              SizedBox(height: size.height * 0.01),

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
                        "Daftar Pengrajin",

                        style: TextStyle(
                          fontSize: size.width * 0.07,

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

              // SEARCH
              TextField(
                decoration: InputDecoration(
                  hintText: "Cari pengrajin...",

                  prefixIcon: const Icon(Icons.search, color: Colors.brown),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // LIST
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.pengrajinList.isEmpty) {
                    return const Center(
                      child: Text("Data pengrajin belum tersedia"),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),

                    itemCount: controller.pengrajinList.length,

                    itemBuilder: (context, index) {
                      final data = controller.pengrajinList[index];

                      return GestureDetector(
                        onTap: () {
                          controller.keProfilPengrajin(data);
                        },

                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),

                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(28),
                          ),

                          child: Row(
                            children: [
                              // FOTO
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),

                                child: Image.asset(
                                  data["foto"],

                                  width: 110,
                                  height: 130,

                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 18),

                              // CONTENT
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      data["nama"],

                                      style: TextStyle(
                                        fontSize: size.width * 0.055,

                                        fontWeight: FontWeight.bold,

                                        color: const Color(0xFF3E2723),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,

                                          size: 20,

                                          color: Colors.brown,
                                        ),

                                        const SizedBox(width: 6),

                                        Expanded(
                                          child: Text(
                                            data["lokasi"],

                                            style: TextStyle(
                                              fontSize: size.width * 0.038,

                                              color: Colors.brown,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,

                                          color: Colors.orange,

                                          size: 22,
                                        ),

                                        const SizedBox(width: 6),

                                        Text(
                                          data["rating"],

                                          style: TextStyle(
                                            fontSize: size.width * 0.04,

                                            fontWeight: FontWeight.bold,

                                            color: const Color(0xFF3E2723),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const Icon(
                                Icons.arrow_forward_ios,

                                size: 18,

                                color: Color(0xFF5A3116),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
