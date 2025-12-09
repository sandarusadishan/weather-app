import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors - Next Level Blue & White Theme
  static const Color primaryColor = Color(0xFF2962FF); // Electric Blue
  static const Color secondaryColor = Color(0xFFE3F2FD); // Very Light Blue
  static const Color accentColor = Color(0xFFFF9100); // Vivid Orange (Contrast)
  static const Color darkText = Color(0xFF0D47A1); // Deep Indigo/Blue for text
  static const Color mediumText = Color(0xFF5472D3); // Soft Blue-Grey
  static const Color lightText = Colors.white;

  // Modern Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF6DD5FA), // Cool Blue
      Color(0xFFFFFFFF), // White
    ],
    stops: [0.0, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xCCFFFFFF), // 80% White
      Color(0x99FFFFFF), // 60% White
    ],
  );

  // Text Styles
  static TextStyle get displayLarge => GoogleFonts.outfit(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: darkText,
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(2, 2),
        blurRadius: 4,
      ),
    ],
  );
  
  static TextStyle get titleLarge => GoogleFonts.outfit(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: darkText,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: darkText.withOpacity(0.9),
  );
  
  static TextStyle get bodyMedium => GoogleFonts.outfit(
    fontSize: 14,
    color: darkText.withOpacity(0.7),
  );
}
