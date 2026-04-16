import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.task_alt,
      size: size,
      color: Colors.white,
    );
  }
}

class AppColors {
  static const darkPurple = Color(0xFF2D2249);
}