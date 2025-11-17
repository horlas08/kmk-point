import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final VoidCallback? onPressed;

  final bool isOutline;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    this.child,
    this.text,
    this.onPressed,
    this.isOutline = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = isOutline
        ? Colors.transparent
        : (backgroundColor ?? Colors.blue);

    final Color br = borderColor ?? (isOutline ? Colors.blue : Colors.transparent);

    final Color txt = textColor ??
        (isOutline ? Colors.blue : Colors.white);

    return TouchableOpacity(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: br, width: 1.2),
        ),
        child: Center(
          child: child ??
              Text(
                text ?? '',
                style: TextStyle(
                  color: txt,
                  fontWeight: FontWeight.w600,
                ),
              ),
        ),
      ),
    );
  }
}
