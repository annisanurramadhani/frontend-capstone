import 'package:get/get.dart';

class PengrajinService extends GetConnect {

  Future<Map<String, dynamic>>
      getDashboardPengrajin() async {

    final response =
        await get('/pengrajin/dashboard');

    if (response.statusCode == 200) {
      return response.body;
    }

    throw Exception('Gagal');
  }
}