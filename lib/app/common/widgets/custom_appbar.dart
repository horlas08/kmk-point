import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_system/app/constants/image_path.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool centerTitle;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;

  const CustomAppbar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.showBack = true,
    this.onBack,
    this.actions,
    this.backgroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!.tr) : null),
      centerTitle: centerTitle,
      leading: showBack
          ? TouchableOpacity(
              onTap: onBack ?? () => Get.back(),
              child: Image.asset(arrowBackImage, width: 20, height: 20),
            )
          : null,
      actions: actions,
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: elevation ?? 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: backgroundColor ?? Colors.white,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}
