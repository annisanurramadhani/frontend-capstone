part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const MASUK = _Paths.MASUK;
  static const DAFTAR = _Paths.DAFTAR;
  static const SPLASH = _Paths.SPLASH;
  static const HALAMAN_UTAMA = _Paths.HALAMAN_UTAMA;

  static const BELAJAR_ANYAMAN = _Paths.BELAJAR_ANYAMAN;
  static const MATERI_ANYAMAN = _Paths.MATERI_ANYAMAN;
  static const DETAIL_VIDEO = _Paths.DETAIL_VIDEO;
  static const DAFTAR_PENGRAJIN = _Paths.DAFTAR_PENGRAJIN;
  static const PROFIL_PENGRAJIN = _Paths.PROFIL_PENGRAJIN;

  static const TAHAPAN_KELAS = _Paths.TAHAPAN_KELAS;
  static const PILIH_JADWAL = _Paths.PILIH_JADWAL;
  static const KONFIRMASI_PEMBAYARAN = _Paths.KONFIRMASI_PEMBAYARAN;
  static const PEMBAYARAN_PELATIHAN = _Paths.PEMBAYARAN_PELATIHAN;

  static const PEMBAYARAN_BERHASIL = _Paths.PEMBAYARAN_BERHASIL;
  static const JADWAL_SAYA = _Paths.JADWAL_SAYA;
  static const RIWAYAT_KELAS = _Paths.RIWAYAT_KELAS;
  static const PRODUK_ANYAMAN = _Paths.PRODUK_ANYAMAN;

  static const DETAIL_PRODUK = _Paths.DETAIL_PRODUK;
  static const PEMBAYARAN_PRODUK = _Paths.PEMBAYARAN_PRODUK;
  static const PROFIL = _Paths.PROFIL;
  static const EDIT_PROFIL = _Paths.EDIT_PROFIL;

  static const SERTIFIKAT = _Paths.SERTIFIKAT;
  static const NOTIFIKASI = _Paths.NOTIFIKASI;
  static const OTP_LOGIN = _Paths.OTP_LOGIN;
  static const LUPA_PASSWORD = _Paths.LUPA_PASSWORD;

  static const OTP_LUPA_PASSWORD = _Paths.OTP_LUPA_PASSWORD;
  static const PASSWORD_BARU = _Paths.PASSWORD_BARU;
  static const DETAIL_KELAS = _Paths.DETAIL_KELAS;
  static const LIHAT_PESANAN = _Paths.LIHAT_PESANAN;
  static const RIWAYAT_AKTIVITAS = _Paths.RIWAYAT_AKTIVITAS;
}

abstract class _Paths {
  _Paths._();

  static const MASUK = '/masuk';
  static const DAFTAR = '/daftar';
  static const SPLASH = '/splash';
  static const HALAMAN_UTAMA = '/halaman-utama';

  static const BELAJAR_ANYAMAN = '/belajar-anyaman';
  static const MATERI_ANYAMAN = '/materi-anyaman';
  static const DAFTAR_PENGRAJIN = '/daftar-pengrajin';
  static const PROFIL_PENGRAJIN = '/profil-pengrajin';

  static const TAHAPAN_KELAS = '/tahapan-kelas';
  static const PILIH_JADWAL = '/pilih-jadwal';
  static const KONFIRMASI_PEMBAYARAN = '/konfirmasi-pembayaran';
  static const PEMBAYARAN_PELATIHAN = '/pembayaran-pelatihan';

  static const PEMBAYARAN_BERHASIL = '/pembayaran-berhasil';
  static const JADWAL_SAYA = '/jadwal-saya';
  static const RIWAYAT_KELAS = '/riwayat-kelas';
  static const PRODUK_ANYAMAN = '/produk-anyaman';

  static const DETAIL_PRODUK = '/detail-produk';
  static const PEMBAYARAN_PRODUK = '/pembayaran-produk';
  static const PROFIL = '/profil';
  static const EDIT_PROFIL = '/edit-profil';

  static const SERTIFIKAT = '/sertifikat';
  static const NOTIFIKASI = '/notifikasi';
  static const OTP_LOGIN = '/otp-login';
  static const LUPA_PASSWORD = '/lupa-password';

  static const OTP_LUPA_PASSWORD = '/otp-lupa-password';
  static const PASSWORD_BARU = '/password-baru';
  static const DETAIL_KELAS = '/detail-kelas';
  static const DETAIL_VIDEO = '/detail-video';
  static const LIHAT_PESANAN = '/lihat-pesanan';

  static const RIWAYAT_AKTIVITAS = '/riwayat-aktivitas';
}
