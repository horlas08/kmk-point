
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../constants/colors.dart';

class OTPTextField extends StatelessWidget {
  OTPTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.onCompleted,
    this.smsRetriever,
    this.validator,
    this.length,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onCompleted;
  final String? Function(String?)? validator;
  final SmsRetriever? smsRetriever;
  final int? length;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 52.h,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'poppins'
      ),
      decoration: BoxDecoration(
        border: null,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final submittedPinTheme = PinTheme(
      width: 48.w,
      height: 52.h,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'poppins'
      ),
      decoration: BoxDecoration(
         border: Border.all(
              color: AppColors.primary,
      ),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final cursor = Container(
      width: 48.w,
      height: 52.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primary,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 50.5.w,
          height: 56.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.grey
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    return Pinput(
      submittedPinTheme: submittedPinTheme,
      smsRetriever: smsRetriever,
      preFilledWidget: preFilledWidget,
      onCompleted: onCompleted,
      length: length ?? 6,
      useNativeKeyboard: false,
      pinAnimationType: PinAnimationType.scale,
      controller: controller,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      showCursor: true,
      cursor: cursor,
      validator: validator,
      keyboardType: TextInputType.number,
      autofocus: true,
    );
  }
}
