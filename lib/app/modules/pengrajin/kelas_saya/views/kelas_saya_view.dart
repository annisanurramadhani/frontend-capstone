import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/kelas_saya_controller.dart';
import '../../../../global_widgets/navbar_pengrajin.dart';

class KelasSayaView extends GetView<KelasSayaController> {
  const KelasSayaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,

        title: const Text(
          "Kelas Saya",
          style: TextStyle(
            color: Color(0xFF5A3116),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF5A3116),
              size: 30,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kelola kelas dan murid Anda hari ini.",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),

            const SizedBox(height: 25),

            Obx(
              () => Row(
                children: [
                  Expanded(child: tabButton(title: "Akan Datang", index: 0)),

                  const SizedBox(width: 10),

                  Expanded(child: tabButton(title: "Berlangsung", index: 1)),

                  const SizedBox(width: 10),

                  Expanded(child: tabButton(title: "Selesai", index: 2)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: controller.kelasList.length,

                  itemBuilder: (context, index) {
                    final kelas = controller.kelasList[index];

                    return kelasCard(kelas);
                  },
                );
              }),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const NavbarPengrajin(currentIndex: 0),
    );
  }

  Widget tabButton({required String title, required int index}) {
    final active = controller.selectedTab.value == index;

    return InkWell(
      onTap: () {
        controller.changeTab(index);
      },
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF5A3116) : const Color(0xFFF8F3EF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: active ? Colors.white : const Color(0xFF5A3116),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget kelasCard(dynamic kelas) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 10)],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F3EF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.school, color: Color(0xFF5A3116)),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kelas["namaKelas"],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text("${kelas["jamMulai"]} - ${kelas["jamSelesai"]}"),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "Murid",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF5A3116),
            ),
          ),

          const SizedBox(height: 10),

          ...List.generate(kelas["murid"].length, (i) {
            final murid = kelas["murid"][i];

            return ListTile(
              contentPadding: EdgeInsets.zero,

              leading: const CircleAvatar(),

              title: Text(murid["nama"]),

              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            );
          }),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.calendar_month),
              label: const Text("Lihat Detail"),
            ),
          ),
        ],
      ),
    );
  }
}
