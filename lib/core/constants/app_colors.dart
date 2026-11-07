import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds - Clean Island Airy Palette
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF1F5F9);
  
  // Glassmorphic layers
  static Color glassBackground = Colors.white.withValues(alpha: 0.85);
  static Color glassBorder = Colors.white.withValues(alpha: 0.9);
  static Color glassBorderSubtle = const Color(0xFFE2E8F0).withValues(alpha: 0.7);

  // Primary Blues & Sky Accents
  static const Color primary = Color(0xFF0284C7);       // Sky 600
  static const Color primaryDark = Color(0xFF0369A1);   // Sky 700
  static const Color primaryLight = Color(0xFF38BDF8);  // Sky 400
  static const Color oceanBlue = Color(0xFF2563EB);     // Blue 600
  static const Color electricCyan = Color(0xFF06B6D4);  // Cyan 500
  static const Color softCyan = Color(0xFFE0F2FE);      // Sky 100
  static const Color iceBlue = Color(0xFFF0F9FF);       // Sky 50

  // Text Colors (High Contrast Charcoal)
  static const Color textPrimary = Color(0xFF0F172A);   // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8);     // Slate 400
  static const Color textLight = Color(0xFFCBD5E1);     // Slate 300

  // Status & Badges
  static const Color onlineGreen = Color(0xFF10B981);   // Emerald 500
  static const Color onlineGreenGlow = Color(0xFF34D399);// Emerald 400
  static const Color accentPurple = Color(0xFF8B5CF6);  // Violet 500
  static const Color accentAmber = Color(0xFFF59E0B);   // Amber 500

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0284C7), Color(0xFF2563EB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanBlueGradient = LinearGradient(
    colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient islandGlowGradient = LinearGradient(
    colors: [Color(0xFFBAE6FD), Color(0xFFE0E7FF), Color(0xFFCCFBF1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGlowGradient = LinearGradient(
    colors: [Color(0x3338BDF8), Color(0x112563EB)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

