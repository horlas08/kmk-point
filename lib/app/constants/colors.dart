import 'package:flutter/material.dart';

sealed class AppColors {
  static const primary =  Color(0xFF155DFC);
  static const primaryBgLight =  Color(0xFFE7EFFF);
  static const grey =  Color(0xFF4A5565);
  static const hintText =  Color(0xFF717182);
  static const formIcon =  Color(0xFF4A5565);
  static const black =  Color(0xFF363636);
  static const stroke = Color(0xFFE5E7EB);
  static const error = Color(0xFFEB5757);
  static const navBackgroundColor = Color(0xff1D1D1D);

  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0179FF), 
      Color(0xFF0795F6),
      Color(0xFF02B3ED),
    ],
    stops: [0.0, 0.5, 1.0],
  );
}