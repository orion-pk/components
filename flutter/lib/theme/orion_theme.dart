import 'package:flutter/material.dart';

/// Orion Design System Core Tokens
class OrionColors {
  OrionColors._();

  // Primary
  static const Color primary = Color(0xFF02658B);
  static const Color primaryHover = Color(0xFF014D6B);
  static const Color primaryLight = Color(0xFFE5F3F7);
  static const Color primaryBorder = Color(0xFFBFDBFE);

  // Success / Green
  static const Color statusGreen = Color(0xFF10B981);
  static const Color statusGreenBg = Color(0xFFD1FAE5);
  static const Color statusGreenBorder = Color(0xFFA7F3D0);

  // Danger / Red
  static const Color statusRed = Color(0xFFEF4444);
  static const Color statusRedBg = Color(0xFFFEF2F2);
  static const Color statusRedBorder = Color(0xFFFCA5A5);
  static const Color danger = Color(0xFF9F1239);
  static const Color dangerHover = Color(0xFF881337);
  static const Color dangerBg = Color(0xFFFFE4E6);

  // Warning / Orange
  static const Color statusOrange = Color(0xFFF59E0B);
  static const Color statusOrangeBg = Color(0xFFFEF3C7);
  static const Color statusOrangeBorder = Color(0xFFFDE68A);

  // Info / Blue
  static const Color statusBlue = Color(0xFF3B82F6);
  static const Color statusBlueBg = Color(0xFFEFF6FF);
  static const Color statusBlueBorder = Color(0xFFBFDBFE);

  // Neutral & Surfaces
  static const Color borderColor = Color(0xFFCBD5E1);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color bgSurface = Color(0xFFFFFFFF);
  static const Color bgPage = Color(0xFFF8FAFC);
  static const Color secondaryBg = Color(0xFFF1F5F9);

  // Text
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF334155);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textSubtle = Color(0xFF94A3B8);
}

class OrionRadius {
  OrionRadius._();

  static const double smValue = 6.0;
  static const double mdValue = 8.0;
  static const double lgValue = 12.0;
  static const double fullValue = 9999.0;

  static final BorderRadius sm = BorderRadius.circular(smValue);
  static final BorderRadius md = BorderRadius.circular(mdValue);
  static final BorderRadius lg = BorderRadius.circular(lgValue);
  static final BorderRadius full = BorderRadius.circular(fullValue);
}

class OrionShadows {
  OrionShadows._();

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.04),
      offset: Offset(0, 1),
      blurRadius: 3,
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.07),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
  ];
}
