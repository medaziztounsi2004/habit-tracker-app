import 'package:flutter/material.dart';

/// Premium glass design system inspired by iOS/Opal
class GlassTheme {
  // === COLOR SYSTEM ===
  static const Color backgroundDark = Color(0xFF0B1220);
  static const Color backgroundNavy = Color(0xFF0D1525);
  static const Color glassBlue = Color(0xFF6EA8FF);
  static const Color glassCyan = Color(0xFF00D4FF);
  static const Color glassPurple = Color(0xFF8B5CF6);
  
  // === BLUR VALUES ===
  static const double blurCard = 15.0;        // Cards: sigma 12-20
  static const double blurButton = 10.0;      // Buttons: sigma 8-12
  static const double blurHeavy = 25.0;       // Modals/overlays
  
  // === OPACITY VALUES ===
  static const double glassTintWhite = 0.08;  // White tint 8-10%
  static const double glassTintBlue = 0.12;   // Blue tint 10-14%
  static const double borderOpacity = 0.25;   // Border 20-30%
  static const double shadowOpacity = 0.20;   // Shadow 15-25%
  static const double noiseOpacity = 0.03;    // Grain 2-4%
  
  // === GLASS GRADIENT ===
  static LinearGradient get glassGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.12),
      glassBlue.withOpacity(0.08),
      Colors.white.withOpacity(0.05),
    ],
    stops: const [0.0, 0.5, 1.0],
  );
  
  // === VIBRANCY OVERLAY (fake iOS vibrancy) ===
  static LinearGradient get vibrancyOverlay => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.white.withOpacity(0.05),
      glassCyan.withOpacity(0.03),
      Colors.transparent,
    ],
  );
  
  // === BORDER ===
  static Border get glassBorder => Border.all(
    color: Colors.white.withOpacity(borderOpacity),
    width: 1.0,
  );
  
  // === SHADOWS ===
  static List<BoxShadow> get glassShadow => [
    // Outer depth shadow
    BoxShadow(
      color: Colors.black.withOpacity(shadowOpacity),
      blurRadius: 30,
      spreadRadius: 0,
      offset: const Offset(0, 10),
    ),
    // Soft ambient shadow
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 60,
      spreadRadius: -10,
      offset: const Offset(0, 20),
    ),
  ];
  
  // === GLOW EFFECT ===
  static BoxShadow glowShadow(Color color) => BoxShadow(
    color: color.withOpacity(0.3),
    blurRadius: 30,
    spreadRadius: 5,
  );
  
  // === TEXT STYLES ===
  static TextStyle get glassTitle => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    shadows: [
      Shadow(
        color: Colors.black26,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );
  
  static TextStyle get glassSubtitle => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.7),
  );
  
  static TextStyle get glassLabel => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.white.withOpacity(0.6),
  );
}
