import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profil_pelatih_controller.dart';

class EditProfilPelatihView extends GetView<EditProfilPelatihController> {
  const EditProfilPelatihView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF3E2723),
            size: 20,
          ),
        ),
        title: const Text(
          "Edit Profil",
          style: TextStyle(
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF5A3116)),
          );
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 32),
          child: Column(
            children: [
              // ── FOTO PROFIL ─────────────────────────────────────────
              GestureDetector(
                onTap: controller.pilihFoto,
                child: Obx(() {
                  final hasSelected = controller.selectedImage.value != null;
                  final hasUrl = controller.fotoUrl.value.isNotEmpty;

                  ImageProvider? imageProvider;
                  if (hasSelected) {
                    imageProvider = FileImage(controller.selectedImage.value!);
                  } else if (hasUrl) {
                    imageProvider = NetworkImage(
                      "http://192.168.18.72:3000/uploads/${controller.fotoUrl.value}",
                    );
                  }

                  return Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3EAE0),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: const Color(0xFFF0E6DD),
                              width: 2,
                            ),
                            image: imageProvider != null
                                ? DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: imageProvider == null
                              ? const Icon(
                                  Icons.person_rounded,
                                  size: 52,
                                  color: Color(0xFF5A3116),
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: const Color(0xFF5A3116),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFFDF8F3),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 8),

              const Text(
                "Ketuk untuk ganti foto",
                style: TextStyle(fontSize: 12, color: Color(0xFF8B6347)),
              ),

              const SizedBox(height: 24),

              // ── SECTION: DATA DIRI ──────────────────────────────────
              _SectionLabel(
                icon: Icons.person_outline_rounded,
                title: "Data Diri",
              ),
              const SizedBox(height: 12),

              _InputField(
                controller: controller.namaC,
                label: "Nama Lengkap",
                icon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 12),

              _InputField(
                controller: controller.noHpC,
                label: "Nomor HP",
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              _InputField(
                controller: controller.alamatC,
                label: "Alamat",
                icon: Icons.location_on_outlined,
                maxLines: 2,
              ),

              const SizedBox(height: 24),

              // ── SECTION: PROFIL PENGRAJIN ───────────────────────────
              _SectionLabel(
                icon: Icons.workspace_premium_outlined,
                title: "Profil Pengrajin",
              ),
              const SizedBox(height: 12),

              _InputField(
                controller: controller.pengalamanC,
                label: "Pengalaman",
                icon: Icons.history_edu_outlined,
                hint: "Contoh: 5 Tahun",
              ),
              const SizedBox(height: 12),

              _InputField(
                controller: controller.deskripsiC,
                label: "Deskripsi",
                icon: Icons.description_outlined,
                maxLines: 4,
              ),

              const SizedBox(height: 28),

              // ── TOMBOL SIMPAN ───────────────────────────────────────
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.simpan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A3116),
                      disabledBackgroundColor: const Color(0xFFBDBDBD),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.save_rounded, size: 18),
                              SizedBox(width: 8),
                              Text(
                                "Simpan Perubahan",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ── SECTION LABEL ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionLabel({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFF3EAE0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 17, color: const Color(0xFF5A3116)),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF3E2723),
          ),
        ),
      ],
    );
  }
}

// ── INPUT FIELD ───────────────────────────────────────────────────────────────

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? hint;
  final int maxLines;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14, color: Color(0xFF3E2723)),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(fontSize: 13, color: Color(0xFF8B6347)),
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFBCA99A)),
        prefixIcon: Icon(icon, size: 20, color: const Color(0xFF8B6347)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFF0E6DD), width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFF0E6DD), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF5A3116), width: 1.5),
        ),
      ),
    );
  }
}
