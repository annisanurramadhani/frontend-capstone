import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pesan_pelatihan_controller.dart';

class PesanPelatihanView extends GetView<PesanPelatihanController> {
  const PesanPelatihanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pesan Pelatihan",
          style: TextStyle(
            color: Color(0xFF5A3116),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF5A3116)),
      ),

      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================
              // CARD INFO KELAS
              // =====================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5E3C).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.school_outlined,
                            color: Color(0xFF8B5E3C),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.kelas["namaKelas"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5A3116),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Pembayaran",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "Rp ${controller.kelas["harga"]}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF8B5E3C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =====================
              // LABEL SECTION
              // =====================
              const Text(
                "Data Peserta",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A3116),
                ),
              ),

              const SizedBox(height: 16),

              // =====================
              // NAMA
              // =====================
              TextFormField(
                controller: controller.namaController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF8B5E3C)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Nama wajib diisi";
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // =====================
              // NO HP
              // =====================
              TextFormField(
                controller: controller.noTelponController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "No Telepon",
                  prefixIcon: const Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF8B5E3C)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Nomor telepon wajib diisi";
                  return null;
                },
              ),

              const SizedBox(height: 28),

              // =====================
              // LABEL SECTION
              // =====================
              const Text(
                "Jadwal Pelatihan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A3116),
                ),
              ),

              const SizedBox(height: 16),

              // =====================
              // TANGGAL
              // =====================
              TextFormField(
                controller: controller.tanggalController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Tanggal Pelatihan",
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF8B5E3C)),
                  ),
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF8B5E3C),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    controller.tanggalController.text =
                        "${picked.day}-${picked.month}-${picked.year}";
                  }
                },
              ),

              const SizedBox(height: 16),

              // =====================
              // JAM
              // =====================
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.jamPelatihan.value.isEmpty
                      ? null
                      : controller.jamPelatihan.value,
                  decoration: InputDecoration(
                    labelText: "Jam Pelatihan",
                    prefixIcon: const Icon(Icons.access_time_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF8B5E3C)),
                    ),
                  ),
                  items: controller.jamList
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.jamPelatihan.value = value.toString();
                  },
                ),
              ),

              const SizedBox(height: 28),

              // =====================
              // LABEL SECTION
              // =====================
              const Text(
                "Metode Pembayaran",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A3116),
                ),
              ),

              const SizedBox(height: 16),

              // =====================
              // METODE PEMBAYARAN (CARD PILIHAN)
              // =====================
              Obx(
                () => Column(
                  children: controller.metodePembayaran.map((item) {
                    final isSelected =
                        controller.metodeBayar.value == item["kode"];
                    return GestureDetector(
                      onTap: () {
                        controller.metodeBayar.value = item["kode"];
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF8B5E3C).withOpacity(0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF8B5E3C)
                                : Colors.grey.shade200,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF8B5E3C).withOpacity(0.15)
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                item["kode"] == "gopay"
                                    ? Icons.account_balance_wallet_outlined
                                    : Icons.qr_code_outlined,
                                color: isSelected
                                    ? const Color(0xFF8B5E3C)
                                    : Colors.grey.shade500,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                item["nama"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: isSelected
                                      ? const Color(0xFF5A3116)
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFF8B5E3C),
                                size: 22,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 32),

              // =====================
              // BUTTON
              // =====================
              SizedBox(
                width: double.infinity,
                height: 55,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.lanjutBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5E3C),
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
                        : const Text(
                            "Lanjut Pembayaran",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
