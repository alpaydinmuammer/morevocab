import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF004A94); // Royal Blue
  static const Color secondaryColor = Color(0xFF43C3DD); // Sky Blue/Cyan
  static const Color accentColor = Color(0xFFD9EDF8); // Very Light Blue

  // Success/Error colors for swipe feedback
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFE53935);

  // Light theme colors
  static const Color lightBackground = Color(0xFFD9EDF8); // Soft Sky
  static const Color lightSurface = Colors.white;
  static const Color lightOnSurface = Color(0xFF001B2C); // Deep Navy Text

  // Dark theme colors
  static const Color darkBackground = Color(0xFF001B2C); // Deep Navy Background
  static const Color darkSurface = Color(0xFF002B44); // Slightly lighter Navy
  static const Color darkOnSurface = Color(0xFFD9EDF8);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: lightSurface,
        onSurface: lightOnSurface,
      ),
      extensions: [AppColors.light],
      scaffoldBackgroundColor: lightBackground,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        },
      ),
      textTheme: _buildTextTheme(lightOnSurface),
      appBarTheme: AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: lightOnSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: lightOnSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 8,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: darkSurface,
        onSurface: darkOnSurface,
      ),
      extensions: [AppColors.dark],
      scaffoldBackgroundColor: darkBackground,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        },
      ),
      textTheme: _buildTextTheme(darkOnSurface),
      appBarTheme: AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: darkOnSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkOnSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 8,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(Color color) {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final List<Color> arcadeGradient;
  final List<Color> settingsGradient;
  final Color arcadeShadow;
  final Color settingsShadow;

  const AppColors({
    required this.arcadeGradient,
    required this.settingsGradient,
    required this.arcadeShadow,
    required this.settingsShadow,
  });

  @override
  AppColors copyWith({
    List<Color>? arcadeGradient,
    List<Color>? settingsGradient,
    Color? arcadeShadow,
    Color? settingsShadow,
  }) {
    return AppColors(
      arcadeGradient: arcadeGradient ?? this.arcadeGradient,
      settingsGradient: settingsGradient ?? this.settingsGradient,
      arcadeShadow: arcadeShadow ?? this.arcadeShadow,
      settingsShadow: settingsShadow ?? this.settingsShadow,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      arcadeGradient: [
        Color.lerp(arcadeGradient[0], other.arcadeGradient[0], t)!,
        Color.lerp(arcadeGradient[1], other.arcadeGradient[1], t)!,
      ],
      settingsGradient: [
        Color.lerp(settingsGradient[0], other.settingsGradient[0], t)!,
        Color.lerp(settingsGradient[1], other.settingsGradient[1], t)!,
      ],
      arcadeShadow: Color.lerp(arcadeShadow, other.arcadeShadow, t)!,
      settingsShadow: Color.lerp(settingsShadow, other.settingsShadow, t)!,
    );
  }

  // Predefined palettes
  static final light = AppColors(
    arcadeGradient: [Colors.orange.shade800, Colors.orange.shade400],
    settingsGradient: [Colors.blueGrey.shade700, Colors.blueGrey.shade400],
    arcadeShadow: Colors.orange.withValues(alpha: 0.3),
    settingsShadow: Colors.blueGrey.withValues(alpha: 0.3),
  );

  static final dark = AppColors(
    arcadeGradient: [Colors.orange.shade900, Colors.orange.shade500],
    settingsGradient: [
      Colors.blueGrey.shade800,
      Colors.blueGrey.shade500,
    ], // Slightly darker for dark mode
    arcadeShadow: Colors.orange.withValues(alpha: 0.2),
    settingsShadow: Colors.blueGrey.withValues(alpha: 0.2),
  );
}
