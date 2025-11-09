import 'package:flutter/material.dart';

import '../../constants/colors.dart';
class MainTitle extends StatelessWidget {
  final String text;
  final double? fontSize;

  const MainTitle({super.key, required this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.2), // Background overlay
      child: ShaderMask(
        shaderCallback: (bounds) {
          return AppColors.mainGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize ?? 32,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            color: Colors.white, // Needed for ShaderMask to work
          ),
        ),
      ),
    );
  }
}

class SemiTitle extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;

  const SemiTitle({super.key, required this.text, this.fontSize, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize ?? 32,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        color: color ?? Colors.white, 
      ),
    );
  }
}

class descriptionText extends StatelessWidget {
  const descriptionText({
    super.key, 
    required this.description, 
    this.size,
    this.align,
    this.color,
    this.weight
    });

  final String description;
  final double? size;
  final TextAlign? align;
  final Color? color;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        fontSize: size ?? 16,
        fontFamily: 'Poppins',
        color: color ?? Colors.white,
      ),
    );
  }
}

class semiDescriptionText extends StatelessWidget {
  const semiDescriptionText({
    super.key, 
    required this.description, 
    this.size});

  final String description;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.2), // Background overlay
      child: ShaderMask(
        shaderCallback: (bounds) {
          return AppColors.mainGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        },
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: size ?? 16,
          fontFamily: 'Poppins',
          color: Colors.white,
          
        ),
      ),
    ));
  }
}