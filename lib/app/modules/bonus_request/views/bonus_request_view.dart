import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bonus_request_controller.dart';

class BonusRequestView extends GetView<BonusRequestController> {
  const BonusRequestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'BonusRequestView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
