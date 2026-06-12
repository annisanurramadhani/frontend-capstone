import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/status_pengiriman_controller.dart';

class StatusPengirimanView extends GetView<StatusPengirimanController> {
  const StatusPengirimanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatusPengirimanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StatusPengirimanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
