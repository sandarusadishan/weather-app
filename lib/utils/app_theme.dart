import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors - Updated for "Daylight / Aurora" Look (Light Mode)
  static const Color primaryColor = Color(0xFF4A90E2); // Bright Sky Blue
  static const Color secondaryColor = Color(0xFFD3E0EA); // Soft Cloud White
  static const Color accentColor = Color(0xFFFF7F50); // Coral Orange (Sun)
  static const Color infoColor = Color(0xFF50E3C2); // Teal/Cyan
  static const Color darkText = Color(0xFF1A1A2E); // Dark Navy for Text
  
  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF89CFF0), // Baby Blue
      Color(0xFFE0F7FA), // Light Cyan
      Colors.white,      // Pure White
    ],
    stops: [0.0, 0.4, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x99FFFFFF), // Highly transparent white
      Color(0x66FFFFFF),
    ],
  );
  
  // Text Styles - Switched to Dark Colors
  static TextStyle get displayLarge => GoogleFonts.poppins(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: darkText,
  );
  
  static TextStyle get titleLarge => GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: darkText,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.poppins(
    fontSize: 18,
    color: darkText.withOpacity(0.8),
  );
  
  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: 14,
    color: darkText.withOpacity(0.6),
  );
}
