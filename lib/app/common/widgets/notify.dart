import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

class Notify {
  // Private constructor to prevent instantiation
  Notify._();
  static const _autoCloseDuration = const Duration(seconds: 5);
  // Success toast
  static Future<void> success(String message, {String? title, Duration? autoCloseDuration = _autoCloseDuration,}) async {
    toastification.show(
      title: Text(message),
      backgroundColor: Colors.white,
     dragToClose: true,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        autoCloseDuration: autoCloseDuration,
        alignment: Alignment.bottomCenter
    );
  }

  // Error toast
  static void error(String message, {String? title, Duration? autoCloseDuration = _autoCloseDuration,}) {
    toastification.show(

      title: Text(title??"Error", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
      description: Text(message, style: TextStyle(color: Colors.red),),
      backgroundColor: Colors.white,
      dragToClose: true,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: autoCloseDuration,
      alignment: Alignment.topCenter

    );
  }

  // Info toast
  static Future<void> info(String message) async {
    toastification.show(
      title: Text(message, style: TextStyle(color: Colors.yellow),),
      backgroundColor: Colors.white,
      dragToClose: true,
    );
  }
}
