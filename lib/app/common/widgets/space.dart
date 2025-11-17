import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget vSpace(double height) {
  return SizedBox(
    height: height.h,
  );
}

Widget hSpace(double width) {
  return SizedBox(
    width: width.w,
  );
}

EdgeInsetsGeometry simPad(double v, double h) {
  return EdgeInsets.symmetric(vertical: v.h, horizontal: h.w);
}
EdgeInsetsGeometry allPad(double a) {
  return EdgeInsets.all(a);
}
EdgeInsetsGeometry onlyPad({double top = 0, double right=0, double bottom=0, double left=0}) {
  return EdgeInsets.only(right: right, left: left, top: top, bottom: bottom );
}

EdgeInsets simMag(double v, double h) {
  return EdgeInsets.symmetric(vertical: v.h, horizontal: h.w);
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

extension BuildContextPlus on BuildContext {
  double dy(double value) => MediaQuery.of(this).size.height * value / 800;

  double dx(double value) => MediaQuery.of(this).size.width * value / 360;
}
