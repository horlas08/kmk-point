import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../data/services/network/network_service.dart';

class ConnectivityController extends GetxController {
RxBool isConnected = true.obs; 
final NetworkService networkInfo = NetworkService(Connectivity());

  @override
  void onInit() {
    super.onInit();
    _checkConnection();
    _listenToConnection();
  }

  Future<void> _checkConnection() async {
    try {
      isConnected.value = await networkInfo.isConnected();
    } catch (e) {

    }
  }

  void _listenToConnection() {
     networkInfo.onConnectivityChanged.listen((ConnectivityResult result) {
      bool hasInternet = result != ConnectivityResult.none;
      isConnected.value = hasInternet;
      print("Connectivity changed: $hasInternet");
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}