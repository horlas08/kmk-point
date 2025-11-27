import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/previous_scan_controller.dart';

class PreviousScanView extends GetView<PreviousScanController> {
  const PreviousScanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PreviousScanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PreviousScanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
