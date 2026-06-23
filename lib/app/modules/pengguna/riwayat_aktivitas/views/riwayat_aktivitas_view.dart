import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/riwayat_aktivitas_controller.dart';

class RiwayatAktivitasView
    extends GetView<RiwayatAktivitasController> {
  const RiwayatAktivitasView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFFDF8F3),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF5A3116),
          ),
        ),
        title: const Text(
          "Riwayat Aktivitas",
          style: TextStyle(
            color: Color(0xFF3E2723),
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child:
                CircularProgressIndicator(
              color: Color(
                0xFF5A3116,
              ),
            ),
          );
        }

        if (controller
            .aktivitas.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment
                      .center,
              children: [
                Icon(
                  Icons.history,
                  size: 70,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                Text(
                  "Belum ada aktivitas",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding:
              const EdgeInsets.all(
            16,
          ),
          itemCount:
              controller
                  .aktivitas.length,
          itemBuilder:
              (context, index) {
            final item =
                controller
                    .aktivitas[index];

            return Container(
              margin:
                  const EdgeInsets.only(
                bottom: 12,
              ),
              padding:
                  const EdgeInsets.all(
                16,
              ),
              decoration:
                  BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius
                        .circular(
                  18,
                ),
                border: Border.all(
                  color:
                      const Color(
                    0xFFF0E6DD,
                  ),
                ),
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFFF3EAE0,
                      ),
                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),
                    ),
                    child:
                        const Icon(
                      Icons.history,
                      color: Color(
                        0xFF5A3116,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          item["judul"] ??
                              "",
                          style:
                              const TextStyle(
                            fontSize:
                                15,
                            fontWeight:
                                FontWeight
                                    .bold,
                            color: Color(
                              0xFF3E2723,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          item["deskripsi"] ??
                              "",
                          style:
                              const TextStyle(
                            fontSize:
                                13,
                            color:
                                Colors
                                    .black87,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Row(
                          children: [
                            const Icon(
                              Icons
                                  .calendar_today,
                              size: 14,
                              color:
                                  Colors
                                      .grey,
                            ),

                            const SizedBox(
                              width:
                                  4,
                            ),

                            Text(
                              item["tanggal"] ??
                                  "",
                              style:
                                  const TextStyle(
                                fontSize:
                                    12,
                                color:
                                    Colors.grey,
                              ),
                            ),

                            const SizedBox(
                              width:
                                  12,
                            ),

                            const Icon(
                              Icons
                                  .access_time,
                              size: 14,
                              color:
                                  Colors
                                      .grey,
                            ),

                            const SizedBox(
                              width:
                                  4,
                            ),

                            Text(
                              item["jam"] ??
                                  "",
                              style:
                                  const TextStyle(
                                fontSize:
                                    12,
                                color:
                                    Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}