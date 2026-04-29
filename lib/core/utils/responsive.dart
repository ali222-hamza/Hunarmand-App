import 'package:flutter/material.dart';

// This class helps make the app responsive on all screen sizes
// It calculates sizes based on the screen width and height
class Responsive {
  // Get screen width
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get screen height
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Get horizontal padding based on screen size
  static double horizontalPadding(BuildContext context) {
    double w = width(context);
    if (w < 360) return 16; // very small phones
    if (w < 480) return 20; // normal phones
    return 24; // large phones
  }

  // Scale font size based on screen
  static double fontSize(BuildContext context, double size) {
    double w = width(context);
    double scale = w / 390; // base design width 390
    return size * scale.clamp(0.85, 1.2);
  }

  // Scale a size value based on screen width
  static double scaleWidth(BuildContext context, double size) {
    return size * (width(context) / 390);
  }

  // Scale a size value based on screen height
  static double scaleHeight(BuildContext context, double size) {
    return size * (height(context) / 844);
  }

  // Check if it's a small screen (below 360 width)
  static bool isSmallScreen(BuildContext context) {
    return width(context) < 360;
  }
}