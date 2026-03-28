import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Colors.blue;
  static const Color secondary = Colors.orange;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red700 = Color(0xFFD32F2F);
  static const Color gray250 = Color(0xFFFAFAFA);
  static const Color gray99 = Color(0xFF999999);
  static const Color borderColorF2 = Color(0xFFF2F2F2);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Colors.blue, Colors.blueAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
