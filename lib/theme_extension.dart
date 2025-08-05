import 'package:flutter/material.dart';

class CustomThemeData {
  final LinearGradient darkPrimaryGradient;
  final LinearGradient lightPrimaryGradient;
  final LinearGradient darkSecondaryGradient;
  final LinearGradient lightSecondaryGradient;

  CustomThemeData({
    required this.darkPrimaryGradient,
    required this.lightPrimaryGradient,
    required this.darkSecondaryGradient,
    required this.lightSecondaryGradient,
  });
}

extension CustomThemeExtension on ThemeData {
  CustomThemeData get customThemeData {
    return CustomThemeData(
      darkPrimaryGradient: LinearGradient(
        colors: [Color(0xFF021421), Color(0xFF02131f)],
      ),
      lightPrimaryGradient: LinearGradient(
        colors: [Color(0xFF4aa4e5), Color(0xFF357aac)],
      ),
      darkSecondaryGradient: LinearGradient(
        colors: [Color(0xFF163f5c), Color(0xFF021421)],
      ),
      lightSecondaryGradient: LinearGradient(
        colors: [Color(0xFF4aa4e5), Color(0xFF357aac)],
      ),
    );
  }
}
