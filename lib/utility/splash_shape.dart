import 'package:flutter/material.dart';
import 'dart:math';

class SplashShape extends StatelessWidget {
  final String imagePath;
  final double left;
  final double top;
  final double right;
  final double bottom;
  final double width;
  final double height;
  final double angle;

  const SplashShape({
    super.key,
    required this.imagePath,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    this.width = 0,
    this.height = 0,
    this.angle = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left > 0 ? left : null,
      top: top > 0 ? top : null,
      right: right > 0 ? right : null,
      bottom: bottom > 0 ? bottom : null,
      child: Transform.rotate(
        angle: angle * pi / 180, // Convert degrees to radians
        child: Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
