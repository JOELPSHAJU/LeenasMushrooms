import 'package:flutter/material.dart';

class AppFonts {
  AppFonts._internal();

  static const dinNextLTProFont = 'DINNextLTPro';
  
  // Add device breakpoint
  static const double _tabletBreakpoint = 600;


  // Add method to calculate font scale factor based on device type
  static double _getFontScaleFactor(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    
    // For tablets (width >= 600), we'll maintain mobile font size
    if (deviceWidth >= _tabletBreakpoint) {
      return 1.0; // Keep mobile scale
    }
    
    return 1.0; // Default scale for mobile
  }

  static TextStyle getAppFont({
    required dynamic context,
    String? language,
    String? fontFamily,
    FontWeight? weight,
    double? size,
    Color? color,
    TextDecoration? underline,
  }) {
    // Calculate the scaled font size
    final double scaleFactor = _getFontScaleFactor(context);
    final double fontSize = (size ?? 14) * scaleFactor;

    return TextStyle(
      decoration: underline ?? TextDecoration.none,
      decorationColor: color,
      decorationThickness: 2,
      fontFamily: fontFamily,
      fontWeight: weight ?? FontWeight.w400,
      fontSize: fontSize,
      color: color ?? Colors.black,
    );
  }

  // Helper method to get font size based on device type
  static double getFontSize(BuildContext context, double baseSize) {
    return baseSize * _getFontScaleFactor(context);
  }
}