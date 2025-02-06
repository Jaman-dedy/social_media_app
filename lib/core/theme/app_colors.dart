// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const primary = Color(0xFF246BFD);
  static const secondary = Color(0xFF1E2F6F);
  static const tertiary = Color(0xFFFF6B6B);

  // Background Colors
  static const backgroundLight = Color(0xFFF8FAFF);
  static const backgroundDark = Color(0xFF121212);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF1E1E1E);

  // Text Colors
  static const textPrimaryLight = Color(0xFF1A1A1A);
  static const textSecondaryLight = Color(0xFF666666);
  static const textPrimaryDark = Color(0xFFF5F5F5);
  static const textSecondaryDark = Color(0xFFB3B3B3);

  // Status Colors
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFB74D);
  static const error = Color(0xFFEF5350);
  static const info = Color(0xFF2196F3);

  // Social Colors
  static const like = Color(0xFFFF4B4B);
  static const share = Color(0xFF4B7BFF);
  static const bookmark = Color(0xFFFFB74D);

  // Gray Scale
  static const gray100 = Color(0xFFF5F5F5);
  static const gray200 = Color(0xFFEEEEEE);
  static const gray300 = Color(0xFFE0E0E0);
  static const gray400 = Color(0xFFBDBDBD);
  static const gray500 = Color(0xFF9E9E9E);
  static const gray600 = Color(0xFF757575);
  static const gray700 = Color(0xFF616161);
  static const gray800 = Color(0xFF424242);
  static const gray900 = Color(0xFF212121);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF246BFD),
      Color(0xFF1E2F6F),
    ],
  );

  // Opacity values
  static const black12 = Colors.black12;
  static const black26 = Colors.black26;
  static const black38 = Colors.black38;
  static const black45 = Colors.black45;
  static const black54 = Colors.black54;
  static const black87 = Colors.black87;

  // Shadow Colors
  static const shadowColor = Color(0x1A000000);
  static const lightShadowColor = Color(0x0A000000);

  // Card Colors
  static const cardLight = Colors.white;
  static const cardDark = Color(0xFF2A2A2A);

  // Input Colors
  static const inputFillLight = Color(0xFFF8FAFF);
  static const inputFillDark = Color(0xFF2A2A2A);
  static const inputBorderLight = Color(0xFFE0E0E0);
  static const inputBorderDark = Color(0xFF424242);

  // Shimmer Colors
  static const shimmerBase = Color(0xFFE0E0E0);
  static const shimmerHighlight = Color(0xFFF5F5F5);
}
