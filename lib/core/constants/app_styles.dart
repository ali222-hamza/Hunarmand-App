import 'package:flutter/material.dart';
import 'app_colors.dart';

// All text styles used across the Hunarmand app
class AppStyles {
  // Big bold heading like "Empowering Skilled Artisans"
  static const TextStyle heading1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textDark,
    height: 1.3,
  );

  // Section headings like "Service Categories"
  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  // Card title like worker names
  static const TextStyle heading3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  // Regular body text
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
    height: 1.5,
  );

  // Small label text
  static const TextStyle small = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );

  // Button text style
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  // White button text
  static const TextStyle buttonWhite = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  // Blue heading like "Join HUNARMAND"
  static const TextStyle headingBlue = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryBlue,
  );

  // Badge text (VERIFIED, NEW etc.)
  static const TextStyle badge = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  // Rupee amount text
  static const TextStyle amount = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
  );

  // Small caps label
  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: AppColors.textGrey,
  );
}