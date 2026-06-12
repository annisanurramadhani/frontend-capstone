import 'package:get/get.dart';

import '../auth/daftar/bindings/daftar_binding.dart';
import '../auth/daftar/views/daftar_view.dart';
import '../auth/lupa_password/bindings/lupa_password_binding.dart';
import '../auth/lupa_password/views/lupa_password_view.dart';
import '../auth/masuk/bindings/masuk_binding.dart';
import '../auth/masuk/views/masuk_view.dart';
import '../auth/otp_login/bindings/otp_login_binding.dart';
import '../auth/otp_login/views/otp_login_view.dart';
import '../auth/otp_lupa_password/bindings/otp_lupa_password_binding.dart';
import '../auth/otp_lupa_password/views/otp_lupa_password_view.dart';
import '../auth/password_baru/bindings/password_baru_binding.dart';
import '../auth/password_baru/views/password_baru_view.dart';
import '../auth/splash/bindings/splash_binding.dart';
import '../auth/splash/views/splash_view.dart';
import '../modules/pengguna/belajar_anyaman/bindings/belajar_anyaman_binding.dart';
import '../modules/pengguna/belajar_anyaman/views/belajar_anyaman_view.dart';
import '../modules/pengguna/daftar_pengrajin/bindings/daftar_pengrajin_binding.dart';
import '../modules/pengguna/daftar_pengrajin/views/daftar_pengrajin_view.dart';
import '../modules/pengguna/detail_kelas/bindings/detail_kelas_binding.dart';
import '../modules/pengguna/detail_kelas/views/detail_kelas_view.dart';
import '../modules/pengguna/detail_pesanan/bindings/detail_pesanan_binding.dart';
import '../modules/pengguna/detail_pesanan/views/detail_pesanan_view.dart';
import '../modules/pengguna/detail_produk/bindings/detail_produk_binding.dart';
import '../modules/pengguna/detail_produk/views/detail_produk_view.dart';
import '../modules/pengguna/detail_video/bindings/detail_video_binding.dart';
import '../modules/pengguna/detail_video/views/detail_video_view.dart';
import '../modules/pengguna/edit_profil/bindings/edit_profil_binding.dart';
import '../modules/pengguna/edit_profil/views/edit_profil_view.dart';
import '../modules/pengguna/halaman_utama/bindings/halaman_utama_binding.dart';
import '../modules/pengguna/halaman_utama/views/halaman_utama_view.dart';
import '../modules/pengguna/jadwal_saya/bindings/jadwal_saya_binding.dart';
import '../modules/pengguna/jadwal_saya/views/jadwal_saya_view.dart';
import '../modules/pengguna/konfirmasi_pembayaran/bindings/konfirmasi_pembayaran_binding.dart';
import '../modules/pengguna/konfirmasi_pembayaran/views/konfirmasi_pembayaran_view.dart';
import '../modules/pengguna/lihat_pesanan/bindings/lihat_pesanan_binding.dart';
import '../modules/pengguna/lihat_pesanan/views/lihat_pesanan_view.dart';
import '../modules/pengguna/materi_anyaman/bindings/materi_anyaman_binding.dart';
import '../modules/pengguna/materi_anyaman/views/materi_anyaman_view.dart';
import '../modules/pengguna/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/pengguna/notifikasi/views/notifikasi_view.dart';
import '../modules/pengguna/pembayaran_berhasil/bindings/pembayaran_berhasil_binding.dart';
import '../modules/pengguna/pembayaran_berhasil/views/pembayaran_berhasil_view.dart';
import '../modules/pengguna/pembayaran_pelatihan/bindings/pembayaran_pelatihan_binding.dart';
import '../modules/pengguna/pembayaran_pelatihan/views/pembayaran_pelatihan_view.dart';
import '../modules/pengguna/pembayaran_produk/bindings/pembayaran_produk_binding.dart';
import '../modules/pengguna/pembayaran_produk/views/pembayaran_produk_view.dart';
import '../modules/pengguna/pemesanan_produk/bindings/pemesanan_produk_binding.dart';
import '../modules/pengguna/pemesanan_produk/views/pemesanan_produk_view.dart';
import '../modules/pengguna/pilih_jadwal/bindings/pilih_jadwal_binding.dart';
import '../modules/pengguna/pilih_jadwal/views/pilih_jadwal_view.dart';
import '../modules/pengguna/produk_anyaman/bindings/produk_anyaman_binding.dart';
import '../modules/pengguna/produk_anyaman/views/produk_anyaman_view.dart';
import '../modules/pengguna/profil/bindings/profil_binding.dart';
import '../modules/pengguna/profil/views/profil_view.dart';
import '../modules/pengguna/profil_pengrajin/bindings/profil_pengrajin_binding.dart';
import '../modules/pengguna/profil_pengrajin/views/profil_pengrajin_view.dart';
import '../modules/pengguna/riwayat_aktivitas/bindings/riwayat_aktivitas_binding.dart';
import '../modules/pengguna/riwayat_aktivitas/views/riwayat_aktivitas_view.dart';
import '../modules/pengguna/riwayat_kelas/bindings/riwayat_kelas_binding.dart';
import '../modules/pengguna/riwayat_kelas/views/riwayat_kelas_view.dart';
import '../modules/pengguna/riwayat_pesanan/bindings/riwayat_pesanan_binding.dart';
import '../modules/pengguna/riwayat_pesanan/views/riwayat_pesanan_view.dart';
import '../modules/pengguna/sertifikat/bindings/sertifikat_binding.dart';
import '../modules/pengguna/sertifikat/views/sertifikat_view.dart';
import '../modules/pengguna/tahapan_kelas/bindings/tahapan_kelas_binding.dart';
import '../modules/pengguna/tahapan_kelas/views/tahapan_kelas_view.dart';
import '../modules/pengguna/status_pengiriman/bindings/status_pengiriman_binding.dart';
import '../modules/pengguna/status_pengiriman/views/status_pengiriman_view.dart';

// app_pages.dart

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    // AUTH
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: Routes.MASUK,
      page: () => const MasukView(),
      binding: MasukBinding(),
    ),

    GetPage(
      name: Routes.DAFTAR,
      page: () => const DaftarView(),
      binding: DaftarBinding(),
    ),

    GetPage(
      name: Routes.OTP_LOGIN,
      page: () => const OtpLoginView(),
      binding: OtpLoginBinding(),
    ),

    GetPage(
      name: Routes.LUPA_PASSWORD,
      page: () => const LupaPasswordView(),
      binding: LupaPasswordBinding(),
    ),

    GetPage(
      name: Routes.OTP_LUPA_PASSWORD,
      page: () => const OtpLupaPasswordView(),
      binding: OtpLupaPasswordBinding(),
    ),

    GetPage(
      name: Routes.PASSWORD_BARU,
      page: () => const PasswordBaruView(),
      binding: PasswordBaruBinding(),
    ),

    // HALAMAN UTAMA
    GetPage(
      name: Routes.HALAMAN_UTAMA,
      page: () => const HalamanUtamaView(),
      binding: HalamanUtamaBinding(),
    ),

    // BELAJAR
    GetPage(
      name: Routes.BELAJAR_ANYAMAN,
      page: () => const BelajarAnyamanView(),
      binding: BelajarAnyamanBinding(),
    ),

    GetPage(
      name: Routes.MATERI_ANYAMAN,
      page: () => const MateriAnyamanView(),
      binding: MateriAnyamanBinding(),
    ),

    GetPage(
      name: Routes.DETAIL_VIDEO,
      page: () => const DetailVideoView(),
      binding: DetailVideoBinding(),
    ),

    // PENGRAJIN
    GetPage(
      name: Routes.DAFTAR_PENGRAJIN,
      page: () => const DaftarPengrajinView(),
      binding: DaftarPengrajinBinding(),
    ),

    GetPage(
      name: Routes.PROFIL_PENGRAJIN,
      page: () => const ProfilPengrajinView(),
      binding: ProfilPengrajinBinding(),
    ),

    // KELAS
    GetPage(
      name: Routes.TAHAPAN_KELAS,
      page: () => const TahapanKelasView(),
      binding: TahapanKelasBinding(),
    ),

    GetPage(
      name: Routes.PILIH_JADWAL,
      page: () => const PilihJadwalView(),
      binding: PilihJadwalBinding(),
    ),

    GetPage(
      name: Routes.KONFIRMASI_PEMBAYARAN,
      page: () => const KonfirmasiPembayaranView(),
      binding: KonfirmasiPembayaranBinding(),
    ),

    GetPage(
      name: Routes.PEMBAYARAN_PELATIHAN,
      page: () => const PembayaranPelatihanView(),
      binding: PembayaranPelatihanBinding(),
    ),

    GetPage(
      name: Routes.PEMBAYARAN_BERHASIL,
      page: () => const PembayaranBerhasilView(),
      binding: PembayaranBerhasilBinding(),
    ),

    GetPage(
      name: Routes.JADWAL_SAYA,
      page: () => const JadwalSayaView(),
      binding: JadwalSayaBinding(),
    ),

    GetPage(
      name: Routes.DETAIL_KELAS,
      page: () => const DetailKelasView(),
      binding: DetailKelasBinding(),
    ),

    GetPage(
      name: Routes.RIWAYAT_KELAS,
      page: () => const RiwayatKelasView(),
      binding: RiwayatKelasBinding(),
    ),

    // PRODUK
    GetPage(
      name: Routes.PRODUK_ANYAMAN,
      page: () => const ProdukAnyamanView(),
      binding: ProdukAnyamanBinding(),
    ),

    GetPage(
      name: Routes.DETAIL_PRODUK,
      page: () => const DetailProdukView(),
      binding: DetailProdukBinding(),
    ),

    GetPage(
      name: Routes.PEMBAYARAN_PRODUK,
      page: () => const PembayaranProdukView(),
      binding: PembayaranProdukBinding(),
    ),

    GetPage(
      name: Routes.LIHAT_PESANAN,
      page: () => const LihatPesananView(),
      binding: LihatPesananBinding(),
    ),

    // PROFIL
    GetPage(
      name: Routes.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),

    GetPage(
      name: Routes.EDIT_PROFIL,
      page: () => const EditProfilView(),
      binding: EditProfilBinding(),
    ),

    GetPage(
      name: Routes.SERTIFIKAT,
      page: () => const SertifikatView(),
      binding: SertifikatBinding(),
    ),

    // NOTIFIKASI
    GetPage(
      name: Routes.NOTIFIKASI,
      page: () => const NotifikasiView(),
      binding: NotifikasiBinding(),
    ),

    GetPage(
      name: _Paths.RIWAYAT_AKTIVITAS,
      page: () => const RiwayatAktivitasView(),
      binding: RiwayatAktivitasBinding(),
    ),
    
    GetPage(
      name: _Paths.PEMESANAN_PRODUK,
      page: () => const PemesananProdukView(),
      binding: PemesananProdukBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_PESANAN,
      page: () => const RiwayatPesananView(),
      binding: RiwayatPesananBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PESANAN,
      page: () => const DetailPesananView(),
      binding: DetailPesananBinding(),
    ),
    GetPage(
      name: _Paths.STATUS_PENGIRIMAN,
      page: () => const StatusPengirimanView(),
      binding: StatusPengirimanBinding(),
    ),
  ];
}
