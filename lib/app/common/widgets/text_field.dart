import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import '../../constants/svg_path.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    required this.itemController,
    this.itemKeyboardType,
    this.itemHintText,
    this.borderColor,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.isAuthField = false,
    this.obscureText = false,
  });

  final TextEditingController itemController;
  final TextInputType? itemKeyboardType;
  final String? itemHintText;
  final Color? borderColor;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isAuthField;
  final bool obscureText;

  @override
  State<CustomInput> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<CustomInput> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    if (widget.isAuthField) {
      _obscureText = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.itemController,
      obscureText: _obscureText,
      keyboardType: widget.itemKeyboardType,
      style: const TextStyle(color: Colors.white),
      onChanged: ((value) => widget.onChanged?.call(value)),
      decoration: InputDecoration(
        suffixIcon: widget.isAuthField
            ? IconButton(
                icon:_obscureText ? Icon(
                   Icons.visibility_off_outlined,
                  color: AppColors.formIcon,
                  size: 20,
                ): SvgPicture.asset(eyeSvg),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: widget.suffixIcon,
              ),

        prefixIcon: widget.prefixIcon,
        hintText: widget.itemHintText,
        hintStyle: TextStyle(color: AppColors.grey.withValues(alpha: 0.4)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 12,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.stroke,
            width: 1,
            strokeAlign: -1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      validator:
          widget.validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
    );
  }
}
