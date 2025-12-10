import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_project_controller.dart';

class ChangeProjectView extends GetView<ChangeProjectController> {
  const ChangeProjectView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeProjectView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChangeProjectView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
