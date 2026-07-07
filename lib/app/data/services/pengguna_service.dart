import 'dart:convert';

import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../providers/api_provider.dart';

class PenggunaService {
  static final box = GetStorage();

  // GET PROFILE
  static Future<dynamic> getProfile() async {
    final token = box.read("token");

    final response = await ApiProvider.getProfile(token);

    return jsonDecode(response.body);
  }

  // UPDATE PROFILE
  static Future<dynamic> updateProfile({
    required String name,
    required String email,
    required String password,
    File? photo,
  }) async {
    final token = box.read("token");

    final response = await ApiProvider.updateProfile(
      token: token,

      name: name,

      email: email,

      password: password,

      photo: photo,
    );

    final data = jsonDecode(response.body);

    if (data['success'] == true) {
      box.write("user", data['user']);
    }

    return data;
  }

  // GET VIDEO TUTORIAL
  static Future<dynamic> getTutorialVideos() async {
    final response = await ApiProvider.getTutorialVideos();

    return jsonDecode(response.body);
  }

  // GET PENGRAJIN
  static Future<dynamic> getPengrajin() async {
    final response = await ApiProvider.getPengrajin();

    return jsonDecode(response.body);
  }

  // GET KELAS
  static Future<Map<String, dynamic>> getKelas() async {
    try {
      final token = box.read("token");

      print("TOKEN KELAS:");
      print(token);

      final response = await ApiProvider.getKelas(token);

      print(response.body);

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // CREATE BOOKING
  static Future<Map<String, dynamic>> createBooking({
    required Map<String, dynamic> data,
  }) async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.createBooking(
        token: token,
        data: data,
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // CEK STATUS BAYAR
  static Future<Map<String, dynamic>> checkStatusBayar(String orderId) async {
    try {
      final response = await ApiProvider.checkStatusBayar(orderId);
      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // GET RIWAYAT BOOKING
  static Future<Map<String, dynamic>> getRiwayatBooking() async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.getRiwayatBooking(token);

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // GET JADWAL KELAS
  static Future<Map<String, dynamic>> getJadwalKelas() async {
    try {
      final token = box.read("token");

      print("TOKEN DI SERVICE:");
      print(token);

      final response = await ApiProvider.getJadwalKelas(token);

      print("STATUS CODE:");
      print(response.statusCode);

      print("BODY:");
      print(response.body);

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // CREATE REVIEW
  static Future<Map<String, dynamic>> createReview({
    required String bookingId,
    required String pengrajinId,
    required int rating,
    required String ulasan,
  }) async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.createReview(
        token: token,
        data: {
          "bookingId": bookingId,
          "pengrajinId": pengrajinId,
          "rating": rating,
          "ulasan": ulasan,
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  //GET SERTIFIKAT
  static Future<Map<String, dynamic>> getSertifikat() async {
    final box = GetStorage();

    final token = box.read("token");

    final response = await ApiProvider.getSertifikat(token);

    return jsonDecode(response.body);
  }

  //GET PRODUK
  static Future<Map<String, dynamic>> getProduk() async {
    final response = await ApiProvider.getProduk();

    return jsonDecode(response.body);
  }

  // GET DETAIL PRODUK
  static Future<Map<String, dynamic>> getDetailProduk(String id) async {
    final response = await ApiProvider.getDetailProduk(id);

    return jsonDecode(response.body);
  }

  // GET KABUPATEN
  static Future<Map<String, dynamic>> getKabupaten() async {
    final token = box.read("token");

    final response = await ApiProvider.getKabupaten(token);

    return jsonDecode(response.body);
  }

  // GET KECAMATAN
  static Future<Map<String, dynamic>> getKecamatan(String kabupaten) async {
    final token = box.read("token");

    final response = await ApiProvider.getKecamatan(token, kabupaten);

    return jsonDecode(response.body);
  }

  // GET ONGKIR
  static Future<Map<String, dynamic>> getOngkir(String kecamatan) async {
    final token = box.read("token");

    final response = await ApiProvider.getOngkir(token, kecamatan);

    return jsonDecode(response.body);
  }

  // GET KERANJANG
  static Future<Map<String, dynamic>> getKeranjang() async {
    final token = box.read("token");

    final response = await ApiProvider.getKeranjang(token);

    return jsonDecode(response.body);
  }

  // TAMBAH KERANJANG
  static Future<Map<String, dynamic>> createKeranjang({
    required String produkId,
    required int qty,
  }) async {
    final token = box.read("token");

    final response = await ApiProvider.createKeranjang(
      token: token,
      produkId: produkId,
      qty: qty,
    );

    return jsonDecode(response.body);
  }

  // HAPUS KERANJANG
  static Future<Map<String, dynamic>> deleteKeranjang(String id) async {
    final token = box.read("token");

    final response = await ApiProvider.deleteKeranjang(token, id);

    return jsonDecode(response.body);
  }

  // UPDATE QTY KERANJANG
  static Future<Map<String, dynamic>> updateKeranjangQty(
    String id,
    int qty,
  ) async {
    final token = box.read("token");

    final response = await ApiProvider.updateKeranjangQty(
      token: token,
      id: id,
      qty: qty,
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> checkoutKeranjang({
    required String namaPenerima,
    required String noTelpon,
    required String alamat,
    required String kabupaten,
    required String kecamatan,
    required String metodeBayar,
  }) async {
    final token = box.read("token");

    final response = await ApiProvider.checkoutKeranjang(
      token: token,
      data: {
        "namaPenerima": namaPenerima,
        "noTelpon": noTelpon,
        "alamat": alamat,
        "kabupaten": kabupaten,
        "kecamatan": kecamatan,
        "metodeBayar": metodeBayar,
      },
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> checkoutLangsung({
    required String produkId,
    required int qty,
    required String namaPenerima,
    required String noTelpon,
    required String alamat,
    required String kabupaten,
    required String kecamatan,
    required String metodeBayar,
  }) async {
    final token = box.read("token");

    final response = await ApiProvider.checkoutLangsung(
      token: token,
      data: {
        "produkId": produkId,
        "qty": qty,
        "namaPenerima": namaPenerima,
        "noTelpon": noTelpon,
        "alamat": alamat,
        "kabupaten": kabupaten,
        "kecamatan": kecamatan,
        "metodeBayar": metodeBayar,
      },
    );

    return jsonDecode(response.body);
  }


  //GET RIWAYAT PEMBELIAN
  static Future<Map<String, dynamic>> getRiwayatPembelian() async {
    final token = box.read("token");

    final response = await ApiProvider.getRiwayatPembelian(token);

    return jsonDecode(response.body);
  }

  //GET NOTIFIKASI
  static Future<Map<String, dynamic>> getNotifikasi() async {
    try {
      final token = box.read("token");

      final response = await ApiProvider.getNotifikasi(token);

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // AKTIVITAS VIDEO
  static Future<void> createAktivitasVideo(String videoId) async {
    try {
      final token = box.read("token");

      await ApiProvider.createAktivitasVideo(token: token, videoId: videoId);
    } catch (_) {}
  }

  // DELETE AKUN
  static Future<dynamic> deleteAkun() async {
    final token = box.read("token");

    final response = await ApiProvider.deleteAkun(token);

    return jsonDecode(response.body);
  }

  // GET AKTIVITAS
  static Future<dynamic> getAktivitas() async {
    final token = box.read("token");

    final response = await ApiProvider.getAktivitas(token);

    return jsonDecode(response.body);
  }

  // GET TOP PRODUK
  static Future<Map<String, dynamic>> getTopProduk() async {
    final token = box.read("token");

    final response = await ApiProvider.getTopProduk(token);

    return jsonDecode(response.body);
  }

  // GET TOP VIEW PRODUK
  static Future<Map<String, dynamic>> getTopViewProduk() async {
    final response = await ApiProvider.getTopViewProduk();

    return jsonDecode(response.body);
  }

  //LOGOUT
  static Future<dynamic> logout() async {
    final token = box.read("token");

    final response = await ApiProvider.logout(token);

    return jsonDecode(response.body);
  }
}
