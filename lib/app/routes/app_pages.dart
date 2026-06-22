import 'package:get/get.dart';

//AUTH
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

//PENGGUNA
import '../modules/pengguna/belajar_anyaman/bindings/belajar_anyaman_binding.dart';
import '../modules/pengguna/belajar_anyaman/views/belajar_anyaman_view.dart';

import '../modules/pengguna/beri_rating/bindings/beri_rating_binding.dart';
import '../modules/pengguna/beri_rating/views/beri_rating_view.dart';

import '../modules/pengguna/checkout/bindings/checkout_binding.dart';
import '../modules/pengguna/checkout/views/checkout_view.dart';

import '../modules/pengguna/daftar_pengrajin/bindings/daftar_pengrajin_binding.dart';
import '../modules/pengguna/daftar_pengrajin/views/daftar_pengrajin_view.dart';

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

import '../modules/pengguna/keranjang/bindings/keranjang_binding.dart';
import '../modules/pengguna/keranjang/views/keranjang_view.dart';

import '../modules/pengguna/lihat_pesanan/bindings/lihat_pesanan_binding.dart';
import '../modules/pengguna/lihat_pesanan/views/lihat_pesanan_view.dart';

import '../modules/pengguna/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/pengguna/notifikasi/views/notifikasi_view.dart';

import '../modules/pengguna/payment_webview/bindings/payment_webview_binding.dart';
import '../modules/pengguna/payment_webview/views/payment_webview_view.dart';

import '../modules/pengguna/pesan_pelatihan/bindings/pesan_pelatihan_binding.dart';
import '../modules/pengguna/pesan_pelatihan/views/pesan_pelatihan_view.dart';

import '../modules/pengguna/pilih_kelas/bindings/pilih_kelas_binding.dart';
import '../modules/pengguna/pilih_kelas/views/pilih_kelas_view.dart';

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

import '../modules/pengguna/sertifikat/bindings/sertifikat_binding.dart';
import '../modules/pengguna/sertifikat/views/sertifikat_view.dart';

//PENGRAJIN
import '../modules/pengrajin/edit_profil_pelatih/bindings/edit_profil_pelatih_binding.dart';
import '../modules/pengrajin/edit_profil_pelatih/views/edit_profil_pelatih_view.dart';

import '../modules/pengrajin/halaman_pengrajin/bindings/halaman_pengrajin_binding.dart';
import '../modules/pengrajin/halaman_pengrajin/views/halaman_pengrajin_view.dart';

import '../modules/pengrajin/kelas_saya/bindings/kelas_saya_binding.dart';
import '../modules/pengrajin/kelas_saya/views/kelas_saya_view.dart';

import '../modules/pengrajin/profil_pelatih/bindings/profil_pelatih_binding.dart';
import '../modules/pengrajin/profil_pelatih/views/profil_pelatih_view.dart';

import '../modules/pengrajin/notifikasi_pengrajin/bindings/notifikasi_pengrajin_binding.dart';
import '../modules/pengrajin/notifikasi_pengrajin/views/notifikasi_pengrajin_view.dart';

// app_pages.dart
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [

  //----------- AUTH ------------//
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

  //----------- PENGGUNA ------------//
    GetPage(
      name: Routes.HALAMAN_UTAMA,
      page: () => const HalamanUtamaView(),
      binding: HalamanUtamaBinding(),
    ),

    GetPage(
      name: Routes.BELAJAR_ANYAMAN,
      page: () => const BelajarAnyamanView(),
      binding: BelajarAnyamanBinding(),
    ),

    GetPage(
      name: Routes.DETAIL_VIDEO,
      page: () => const DetailVideoView(),
      binding: DetailVideoBinding(),
    ),

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

    GetPage(
      name: Routes.JADWAL_SAYA,
      page: () => const JadwalSayaView(),
      binding: JadwalSayaBinding(),
    ),

    GetPage(
      name: Routes.PILIH_KELAS,
      page: () => const PilihKelasView(),
      binding: PilihKelasBinding(),
    ),

    GetPage(
      name: Routes.RIWAYAT_KELAS,
      page: () => const RiwayatKelasView(),
      binding: RiwayatKelasBinding(),
    ),

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
      name: Routes.LIHAT_PESANAN,
      page: () => const LihatPesananView(),
      binding: LihatPesananBinding(),
    ),

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
      name: _Paths.PESAN_PELATIHAN,
      page: () => const PesanPelatihanView(),
      binding: PesanPelatihanBinding(),
    ),

    GetPage(
      name: _Paths.PAYMENT_WEBVIEW,
      page: () => const PaymentWebviewView(),
      binding: PaymentWebviewBinding(),
    ),

    GetPage(
      name: _Paths.BERI_RATING,
      page: () => const BeriRatingView(),
      binding: BeriRatingBinding(),
    ),

    GetPage(
      name: _Paths.KERANJANG,
      page: () => const KeranjangView(),
      binding: KeranjangBinding(),
    ),

    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),

  //----------- PENGRAJIN ------------//
    GetPage(
      name: _Paths.HALAMAN_PENGRAJIN,
      page: () => const HalamanPengrajinView(),
      binding: HalamanPengrajinBinding(),
    ),

    GetPage(
      name: _Paths.KELAS_SAYA,
      page: () => const KelasSayaView(),
      binding: KelasSayaBinding(),
    ),

    GetPage(
      name: _Paths.PROFIL_PELATIH,
      page: () => const ProfilPelatihView(),
      binding: ProfilPelatihBinding(),
    ),

    GetPage(
      name: _Paths.EDIT_PROFIL_PELATIH,
      page: () => const EditProfilPelatihView(),
      binding: EditProfilPelatihBinding(),
    ),

    GetPage(
      name: _Paths.NOTIFIKASI_PENGRAJIN,
      page: () => const NotifikasiPengrajinView(),
      binding: NotifikasiPengrajinBinding(),
    ),
  ];
}
