import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Rx<Barcode?> result = Rx<Barcode?>(null);
  QRViewController? controller;

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result.value = scanData;
    });
  }

  /// Handle camera during hot reload
  void handleHotReload() {
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }
}
