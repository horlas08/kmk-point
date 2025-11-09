import 'package:flutter/material.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final VoidCallback? onPressed;
  const CustomButton({super.key, this.child, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: child ?? Text(text ?? '', style: TextStyle(color:Colors.white),),
        ),
      ),
    );
  }
}
