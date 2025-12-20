import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../common/widgets/notify.dart';
import '../../select_project/controllers/select_project_controller.dart';
import '../repository/scan_service.dart';

class ScanController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Rx<Barcode?> result = Rx<Barcode?>(null);
  QRViewController? controller;
  final isProcessing = false.obs;

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result.value = scanData;
      final code = scanData.code?.toString() ?? '';
      if (code.isEmpty || isProcessing.value) return;
      _handleScan(code);
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

  /// Extract a UUID-like token from the QR string
  String? _extractUuid(String raw) {
    final reg = RegExp(r'\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b');
    final m = reg.firstMatch(raw);
    return m?.group(0);
  }

  Future<void> _handleScan(String raw) async {
    final qrCode = _extractUuid(raw) ?? raw.trim();
    if (qrCode.isEmpty) return;
    try {
      isProcessing.value = true;
      await controller?.pauseCamera();

      // Resolve project id from SelectProjectController
      String projectId = '';
      if (Get.isRegistered<SelectProjectController>()) {
        projectId = Get.find<SelectProjectController>().activeProjectId.value;
      }
      if (projectId.isEmpty) {
        Notify.error('Project not selected');
        await controller?.resumeCamera();
        isProcessing.value = false;
        return;
      }

      // Ensure service is registered
      final service = Get.isRegistered<ScanService>() ? Get.find<ScanService>() : Get.put(ScanService());

      Get.context?.loaderOverlay.show();
      final res = await service.scanQr(qrCode: qrCode, projectId: projectId);
      Get.context?.loaderOverlay.hide();

      final data = res.data;
      if (data is Map && (data['status'] == true || data['code'] == 200) || res.statusCode == HttpStatus.ok) {
        Notify.success(data is Map ? (data['message']?.toString() ?? 'Success') : 'Success');
        Get.back();
      } else {
        Notify.error(data is Map ? (data['message']?.toString() ?? 'Scan failed') : 'Scan failed');
        await controller?.resumeCamera();
      }
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      Notify.error(e.toString());
      await controller?.resumeCamera();
    } finally {
      isProcessing.value = false;
    }
  }
}
