import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_widgets/custom_navbar.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/pesan_pelatihan_controller.dart';

class PesanPelatihanView extends GetView<PesanPelatihanController> {
  const PesanPelatihanView({super.key});

  static void showSuccessDialog() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3EAE0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Color(0xFF5A3116),
                  size: 42,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Pembayaran Berhasil",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Booking pelatihan berhasil dibuat dan pembayaran telah diterima.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.6),
              ),

              const SizedBox(height: 26),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.offAllNamed(Routes.HALAMAN_UTAMA);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A3116),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),

      bottomNavigationBar: const CustomNavbar(currentIndex: -1),

      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            color: const Color(0xFF5A3116),
                            size: w * 0.055,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            "Pesan Kelas",
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
                  child: SizedBox(
                    width: w * 0.82,
                    child: Text(
                      "Lengkapi data sebelum melanjutkan pembayaran",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.034,
                        color: Colors.grey,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: h * 0.02),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(w * 0.045),
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
                      // Badge Level
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _badgeColor(controller.kelas["namaKelas"]),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          controller.kelas["namaKelas"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        controller.kelas["deskripsi"] ?? "-",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3E2723),
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 120,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F5F1),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.schedule_outlined,
                                    color: Color(0xFF5A3116),
                                  ),

                                  const SizedBox(height: 4),

                                  const Text(
                                    "Durasi",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),

                                  const SizedBox(height: 2),

                                  Text(
                                    controller.kelas["durasi"] ?? "-",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3E2723),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Container(
                              height: 120,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F5F1),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xFF5A3116),
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    "Lokasi",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    controller.kelas["lokasi"] ?? "-",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF3E2723),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Divider(color: Colors.grey.shade300),

                      const SizedBox(height: 16),

                      Text(
                        "Rp ${controller.kelas["harga"]}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5A3116),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),
                const Text(
                  "Data Peserta",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),

                const SizedBox(height: 14),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
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
                      TextFormField(
                        controller: controller.namaController,
                        decoration: InputDecoration(
                          labelText: "Nama Lengkap",
                          prefixIcon: const Icon(Icons.person_outline),
                          filled: true,
                          fillColor: const Color(0xFFF8F5F1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: Color(0xFF5A3116),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama wajib diisi";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      TextFormField(
                        controller: controller.noTelponController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Nomor Telepon",
                          prefixIcon: const Icon(Icons.phone_outlined),
                          filled: true,
                          fillColor: const Color(0xFFF8F5F1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: Color(0xFF5A3116),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nomor telepon wajib diisi";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  "Jadwal Pelatihan",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.tanggalController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Tanggal",
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          filled: true,
                          fillColor: const Color(0xFFF8F5F1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFF5A3116),
                            ),
                          ),
                        ),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            initialDate: DateTime.now(),
                          );

                          if (picked != null) {
                            controller.tanggalController.text =
                                "${picked.day}-${picked.month}-${picked.year}";
                          }
                        },
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Obx(
                        () => DropdownButtonFormField<String>(
                          isExpanded: true,
                          initialValue: controller.jamPelatihan.value.isEmpty
                              ? null
                              : controller.jamPelatihan.value,
                          decoration: InputDecoration(
                            labelText: "Jam",
                            prefixIcon: const Icon(Icons.access_time_outlined),
                            filled: true,
                            fillColor: const Color(0xFFF8F5F1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: const BorderSide(
                                color: Color(0xFF5A3116),
                              ),
                            ),
                          ),
                          items: controller.jamList
                              .map(
                                (jam) => DropdownMenuItem(
                                  value: jam,
                                  child: Text(
                                    jam,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            controller.jamPelatihan.value = value ?? "";
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                const Text(
                  "Ringkasan Pembayaran",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w * 0.05),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Biaya Pelatihan",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          Text(
                            "Rp ${controller.kelas["harga"]}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      Divider(color: Colors.grey.shade300),

                      const SizedBox(height: 14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Pembayaran",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2723),
                            ),
                          ),
                          Text(
                            "Rp ${controller.kelas["harga"]}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5A3116),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.lanjutBooking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A3116),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  "Lanjut ke Pembayaran",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _badgeColor(String? namaKelas) {
    if (namaKelas == null) {
      return const Color(0xFF5A3116);
    }

    final nama = namaKelas.toLowerCase();

    if (nama.contains("pemula")) {
      return Colors.green;
    }

    if (nama.contains("menengah")) {
      return Colors.orange;
    }

    if (nama.contains("lanjutan")) {
      return Colors.red;
    }

    return const Color(0xFF5A3116);
  }
}
