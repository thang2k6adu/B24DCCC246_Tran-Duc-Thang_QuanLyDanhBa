import 'package:flutter/material.dart';

class AppTheme {
  // Bảng màu Bento Dark & Mint
  static const Color background = Color(0xFF0A0E1A);
  static const Color surface = Color(0xFF141B2D);
  static const Color surfaceElevated = Color(0xFF1C253B);
  static const Color border = Color(0xFF26354D);
  static const Color borderLight = Color(0xFF334460);

  static const Color primary = Color(0xFF10B981); // Emerald Mint
  static const Color primaryDark = Color(0xFF059669);
  static const Color primaryContainer = Color(0xFF064E3B);

  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color starActive = Color(0xFFF59E0B);
  static const Color starInactive = Color(0xFF475569);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textError = Color(0xFFF87171);

  static const Color callGreen = Color(0xFF10B981);
  static const Color deleteRed = Color(0xFFEF4444);
  static const Color deleteRedBg = Color(0xFF2A1618);

  // Màu sắc nhóm liên hệ
  static Color getGroupBgColor(String group) {
    switch (group.trim()) {
      case 'Gia đình':
        return const Color(0xFF2D151F);
      case 'Bạn bè':
        return const Color(0xFF0B291E);
      case 'Công việc':
        return const Color(0xFF0C243B);
      default:
        return const Color(0xFF2E230E);
    }
  }

  static Color getGroupTextColor(String group) {
    switch (group.trim()) {
      case 'Gia đình':
        return const Color(0xFFFB7185);
      case 'Bạn bè':
        return const Color(0xFF34D399);
      case 'Công việc':
        return const Color(0xFF38BDF8);
      default:
        return const Color(0xFFFCD34D);
    }
  }

  // Danh sách gradient cho Avatar theo tên
  static const List<List<Color>> avatarGradients = [
    [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    [Color(0xFFEC4899), Color(0xFFF43F5E)],
    [Color(0xFF10B981), Color(0xFF059669)],
    [Color(0xFFF59E0B), Color(0xFFD97706)],
    [Color(0xFF06B6D4), Color(0xFF0284C7)],
    [Color(0xFF8B5CF6), Color(0xFFD946EF)],
  ];

  static List<Color> getAvatarGradient(String name) {
    if (name.isEmpty) return avatarGradients[0];
    final hash = name.codeUnits.fold(0, (prev, elem) => prev + elem);
    return avatarGradients[hash % avatarGradients.length];
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accentCyan,
        surface: surface,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
