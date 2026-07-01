import 'dart:convert';

import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class ApiProvider {
  // MOBILE
  static const String mobileBaseUrl = "http://10.62.136.75:3000";

  static const String mobileAuthUrl = "$mobileBaseUrl/api/auth";

  static const String mobilePenggunaUrl = "$mobileBaseUrl/api/pengguna";

  // WEB
  static const String webBaseUrl = "http://localhost:3000";

  static const String webAuthUrl = "$webBaseUrl/api/auth";

  static const String webPenggunaUrl = "$webBaseUrl/api/pengguna";

  // AUTO URL
  static String get baseUrl => kIsWeb ? webBaseUrl : mobileBaseUrl;

  static String get authUrl => kIsWeb ? webAuthUrl : mobileAuthUrl;

  static String get penggunaUrl => kIsWeb ? webPenggunaUrl : mobilePenggunaUrl;

  // Payment URL
  static String get paymentUrl =>
      kIsWeb ? "$webBaseUrl/api/payment" : "$mobileBaseUrl/api/payment";

  // LOGIN
  static Future<http.Response> login(String email, String password) async {
    return await http.post(
      Uri.parse("$authUrl/login"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email, "password": password}),
    );
  }

  // GOOGLE LOGIN
  static Future<http.Response> googleLogin(String idToken) async {
    return await http.post(
      Uri.parse("$authUrl/google"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"idToken": idToken}),
    );
  }

  // VERIFY OTP
  static Future<http.Response> verifyOtp(String email, String otp) async {
    return await http.post(
      Uri.parse("$authUrl/verify-otp"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email, "otp": otp}),
    );
  }

  // RESEND OTP
  static Future<http.Response> resendOtp(String email) async {
    return await http.post(
      Uri.parse("$authUrl/resend-otp"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email}),
    );
  }

  // REGISTER
  static Future<http.Response> register(
    String name,
    String email,
    String password,
  ) async {
    return await http.post(
      Uri.parse("$authUrl/register"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"name": name, "email": email, "password": password}),
    );
  }

  // REQUEST RESET PASSWORD
  static Future<http.Response> requestResetPassword(String email) async {
    return await http.post(
      Uri.parse("$authUrl/request-reset-password"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email}),
    );
  }

  // RESET PASSWORD
  static Future<http.Response> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    return await http.post(
      Uri.parse("$authUrl/reset-password"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      }),
    );
  }

  // GET PROFILE
  static Future<http.Response> getProfile(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/profile"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },
    );
  }

  // UPDATE PROFILE
  static Future<http.Response> updateProfile({
    required String token,
    required String name,
    required String email,
    required String password,
    File? photo,
  }) async {
    var request = http.MultipartRequest(
      "PUT",

      Uri.parse("$penggunaUrl/profile"),
    );

    request.headers["Authorization"] = "Bearer $token";

    request.fields["name"] = name;

    request.fields["email"] = email;

    if (password.isNotEmpty) {
      request.fields["password"] = password;
    }

    if (photo != null) {
      request.files.add(await http.MultipartFile.fromPath("photo", photo.path));
    }

    final streamedResponse = await request.send();

    return await http.Response.fromStream(streamedResponse);
  }

  // GET VIDEO TUTORIAL
  static Future<http.Response> getTutorialVideos() async {
    return await http.get(
      Uri.parse("$penggunaUrl/tutorial-video"),

      headers: {"Content-Type": "application/json"},
    );
  }

  // GET PENGRAJIN
  static Future<http.Response> getPengrajin() async {
    return await http.get(
      Uri.parse("$penggunaUrl/pengrajin"),
      headers: {"Content-Type": "application/json"},
    );
  }

  // GET KELAS
  static Future<http.Response> getKelas(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/kelas"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // CREATE BOOKING
  static Future<http.Response> createBooking({
    required Map<String, dynamic> data,
  }) async {
    return await http.post(
      Uri.parse("$penggunaUrl/booking"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode(data),
    );
  }

  //CEK STATUS BAYAR
  static Future<http.Response> checkStatusBayar(String orderId) async {
    return await http.get(
      Uri.parse("$baseUrl/api/payment/status/$orderId"),
      headers: {"Content-Type": "application/json"},
    );
  }

  // GET RIWAYAT BOOKING
  static Future<http.Response> getRiwayatBooking(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/riwayat-booking"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // GET JADWAL KELAS
  static Future<http.Response> getJadwalKelas(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/jadwal-kelas"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // CREATE REVIEW
  static Future<http.Response> createReview({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return await http.post(
      Uri.parse("$penggunaUrl/review"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data),
    );
  }

  // GET SERTIFIKAT
  static Future<http.Response> getSertifikat(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/sertifikat"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  //GET PRODUK
  static Future<http.Response> getProduk() async {
    return await http.get(
      Uri.parse("$penggunaUrl/produk"),
      headers: {"Content-Type": "application/json"},
    );
  }

  // GET DETAIL PRODUK
  static Future<http.Response> getDetailProduk(String id) async {
    return await http.get(
      Uri.parse("$penggunaUrl/produk/$id"),
      headers: {"Content-Type": "application/json"},
    );
  }

  // GET KABUPATEN
  static Future<http.Response> getKabupaten() async {
    return await http.get(
      Uri.parse("$penggunaUrl/kabupaten"),
      headers: {"Content-Type": "application/json"},
    );
  }

  // GET KECAMATAN
  static Future<http.Response> getKecamatan(String kabupaten) async {
    return await http.get(
      Uri.parse("$penggunaUrl/kecamatan/$kabupaten"),
      headers: {"Content-Type": "application/json"},
    );
  }

  // GET ONGKIR
  static Future<http.Response> getOngkir(String kecamatan) async {
    return await http.get(
      Uri.parse("$penggunaUrl/ongkir/$kecamatan"),
      headers: {"Content-Type": "application/json"},
    );
  }

  // GET KERANJANG
  static Future<http.Response> getKeranjang(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/keranjang"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // TAMBAH KERANJANG
  static Future<http.Response> createKeranjang({
    required String token,
    required String produkId,
    required int qty,
  }) async {
    return await http.post(
      Uri.parse("$penggunaUrl/keranjang"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"produkId": produkId, "qty": qty}),
    );
  }

  // HAPUS KERANJANG
  static Future<http.Response> deleteKeranjang(String token, String id) async {
    return await http.delete(
      Uri.parse("$penggunaUrl/keranjang/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // UPDATE QTY KERANJANG
  static Future<http.Response> updateKeranjangQty({
    required String token,
    required String id,
    required int qty,
  }) async {
    return await http.put(
      Uri.parse("$penggunaUrl/keranjang/$id"),

      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },

      body: jsonEncode({"qty": qty}),
    );
  }

  // CHECKOUT KERANJANG
  static Future<http.Response> checkoutKeranjang({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return await http.post(
      Uri.parse("$penggunaUrl/checkout"),

      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },

      body: jsonEncode(data),
    );
  }

  //GET RIWAYAT PEMBELIAN
  static Future<http.Response> getRiwayatPembelian(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/riwayat-pembelian"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  //GET NOTIFIKASI
  static Future<http.Response> getNotifikasi(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/notifikasi"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  //-------------PENGRAJIN------------//

  // URL PENGRAJIN
  static String get pengrajinUrl => "$baseUrl/api/pengrajin";

  // DASHBOARD PENGRAJIN
  static Future<http.Response> getDashboardPengrajin(String token) async {
    return await http.get(
      Uri.parse("$pengrajinUrl/dashboard"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // KELAS SAYA
  static Future<http.Response> getKelasSaya(String token) async {
    return await http.get(
      Uri.parse("$pengrajinUrl/kelas-saya"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // PROFILE PENGRAJIN
  static Future<http.Response> getProfilePengrajin(String token) async {
    return await http.get(
      Uri.parse("$pengrajinUrl/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  //UPDATE PROFIL PENGRAJIN
  static Future<http.Response> updateProfilePengrajin({
    required String token,
    required String name,
    required String alamat,
    required String noTelpon,
    required String pengalaman,
    required String deskripsi,
    File? photo,
  }) async {
    var request = http.MultipartRequest(
      "PUT",
      Uri.parse("$pengrajinUrl/profile"),
    );

    request.headers["Authorization"] = "Bearer $token";

    request.fields["name"] = name;
    request.fields["alamat"] = alamat;
    request.fields["noTelpon"] = noTelpon;
    request.fields["pengalaman"] = pengalaman;
    request.fields["deskripsi"] = deskripsi;

    if (photo != null) {
      request.files.add(await http.MultipartFile.fromPath("photo", photo.path));
    }

    final streamedResponse = await request.send();

    return await http.Response.fromStream(streamedResponse);
  }

  // GET NOTIFIKASI PENGRAJIN
  static Future<http.Response> getNotifikasiPengrajin(String token) async {
    return await http.get(
      Uri.parse("$pengrajinUrl/notifikasi"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },
    );
  }

  // DELETE AKUN
  static Future<http.Response> deleteAkun(String token) async {
    return await http.delete(
      Uri.parse("$penggunaUrl/delete-account"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // GET AKTIVITAS
  static Future<http.Response> getAktivitas(String token) async {
    return await http.get(
      Uri.parse("$penggunaUrl/aktivitas"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // AKTIVITAS VIDEO
  static Future<http.Response> createAktivitasVideo({
    required String token,
    required String videoId,
  }) async {
    return await http.post(
      Uri.parse("$penggunaUrl/aktivitas-video"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"videoId": videoId}),
    );
  }

  //LOGOUT
  static Future<http.Response> logout(String token) async {
    return await http.post(
      Uri.parse("$penggunaUrl/logout"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }
}
