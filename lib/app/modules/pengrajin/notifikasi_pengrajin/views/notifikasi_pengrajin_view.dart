import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifikasi_pengrajin_controller.dart';

class NotifikasiPengrajinView extends GetView<NotifikasiPengrajinController> {
  const NotifikasiPengrajinView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F3EF),

      appBar: AppBar(
        title: const Text(
          "Notifikasi",
        ),

        backgroundColor:
            const Color(0xFFF8F3EF),
      ),

      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(
            child:
                CircularProgressIndicator(),
          );
        }

        if (controller.notifikasi.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada notifikasi",
            ),
          );
        }

        return RefreshIndicator(
          onRefresh:
              controller.loadData,

          child: ListView.builder(
            padding:
                const EdgeInsets.all(
              20,
            ),

            itemCount:
                controller
                    .notifikasi.length,

            itemBuilder:
                (context, index) {

              final item =
                  controller
                      .notifikasi[index];

              return Container(
                margin:
                    const EdgeInsets.only(
                  bottom: 12,
                ),

                decoration:
                    BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
                ),

                child: ListTile(
                  leading:
                      CircleAvatar(
                    backgroundColor:
                        item["dibaca"] ==
                                true
                            ? Colors
                                .grey
                                .shade200
                            : Colors
                                .orange
                                .shade100,

                    child: const Icon(
                      Icons
                          .notifications,
                      color: Color(
                        0xFF5A3116,
                      ),
                    ),
                  ),

                  title: Text(
                    item["judul"] ??
                        "-",

                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  subtitle: Text(
                    item["pesan"] ??
                        "-",
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
