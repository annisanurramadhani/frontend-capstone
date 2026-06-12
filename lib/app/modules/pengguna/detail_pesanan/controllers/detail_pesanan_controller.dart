import 'package:get/get.dart';

class DetailPesananController extends GetxController {
  late Map dataPesanan;

  @override
  void onInit() {
    super.onInit();

    dataPesanan = Get.arguments ?? {};
  }

  String get nama =>
      dataPesanan["nama"] ?? "-";

  String get noTelpon =>
      dataPesanan["noTelpon"] ?? "-";

  String get alamat =>
      dataPesanan["alamat"] ?? "-";

  String get kecamatan =>
      dataPesanan["kecamatan"] ?? "-";

  int get ongkir =>
      dataPesanan["ongkir"] ?? 0;

  int get total =>
      dataPesanan["total"] ?? 0;

  Map get produk =>
      dataPesanan["produk"] ?? {};
}