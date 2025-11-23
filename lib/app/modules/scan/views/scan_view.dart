import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../controllers/scan_controller.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final ScanController controller = Get.put(ScanController());

  @override
  void reassemble() {
    super.reassemble();
    controller.handleHotReload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: QRView(
                key: controller.qrKey,
                onQRViewCreated: controller.onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: AppColors.primary,
                  overlayColor: Colors.black,

                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Obx(() {
                  return controller.result.value != null
                      ? Text(
                    'Barcode Type: ${controller.result.value!.format}\n'
                        'Data: ${controller.result.value!.code}',
                    textAlign: TextAlign.center,
                  )
                      : const Text('Scan a code');
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
