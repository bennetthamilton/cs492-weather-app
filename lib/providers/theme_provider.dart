import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ColorUtils on Color {
  Color lighten([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    final adjusted = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return adjusted.toColor();
  }

  Color darken([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    final adjusted = hsl.withLightness(
      (hsl.lightness - amount).clamp(0.0, 1.0),
    );
    return adjusted.toColor();
  }
}

class ThemeProvider extends ChangeNotifier {
  bool darkMode = false;

  // Core brand colors
  static const Color brandBlue = Color(0xFF0041B2);
  static const Color brandRedOrange = Color(0xFFFF7043);

  // Tonal variations derived from the two brand colors
  Color get blueDark => brandBlue.darken(0.18);
  Color get blueLight => brandBlue.lighten(0.24);
  Color get blueSoft => brandBlue.lighten(0.38);

  Color get redStrong => brandRedOrange;
  Color get redSoft => brandRedOrange.lighten(0.18);
  Color get redMuted => brandRedOrange.lighten(0.3);

  // Semantic colors
  Color get primaryColor => brandBlue;
  Color get accentColor => redSoft;
  Color get dangerColor => redStrong;
  Color get titleTextColor => redMuted;

  Color get secondaryTextColor =>
      darkMode ? Colors.white70 : Colors.black87;

  Color get overlayColor => Colors.black.withValues(alpha: 0.5);

  ThemeData get lightTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,

      primary: brandBlue,
      onPrimary: Colors.white,

      secondary: redStrong,
      onSecondary: Colors.white,

      tertiary: redSoft,
      onTertiary: Colors.white,

      error: redStrong,
      onError: Colors.white,

      surface: Colors.white,
      onSurface: Colors.black87,

      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: blueSoft.withValues(alpha: 0.08),
      surfaceContainer: blueSoft.withValues(alpha: 0.12),
      surfaceContainerHigh: blueLight.withValues(alpha: 0.14),
      surfaceContainerHighest: blueLight.withValues(alpha: 0.18),

      outline: blueDark.withValues(alpha: 0.25),
      shadow: Colors.black.withValues(alpha: 0.15),

      inverseSurface: blueDark,
      onInverseSurface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: brandBlue),
        titleTextStyle: TextStyle(
          color: redStrong,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      iconTheme: IconThemeData(
        color: brandBlue,
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: redStrong,
        unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.65),
        indicatorColor: redStrong,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? redStrong
              : colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? redSoft.withValues(alpha: 0.45)
              : colorScheme.surfaceContainerHighest;
        }),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: redStrong,
        foregroundColor: Colors.white,
      ),

      cardTheme: CardThemeData(
        elevation: 3,
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: blueLight,
          foregroundColor: Colors.white,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: redStrong,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: brandBlue,
          side: BorderSide(color: colorScheme.outline),
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,

      primary: blueLight,
      onPrimary: Colors.white,

      secondary: redSoft,
      onSecondary: Colors.white,

      tertiary: redMuted,
      onTertiary: Colors.white,

      error: redStrong,
      onError: Colors.white,

      surface: blueDark.withValues(alpha: 0.15),
      onSurface: Colors.white70,

      surfaceContainerLowest: blueDark.withValues(alpha: 0.12),
      surfaceContainerLow: blueDark.withValues(alpha: 0.2),
      surfaceContainer: blueDark.withValues(alpha: 0.24),
      surfaceContainerHigh: brandBlue.withValues(alpha: 0.28),
      surfaceContainerHighest: brandBlue.withValues(alpha: 0.34),

      outline: blueLight.withValues(alpha: 0.3),
      shadow: Colors.black.withValues(alpha: 0.35),

      inverseSurface: Colors.white,
      onInverseSurface: blueDark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: blueLight),
        titleTextStyle: TextStyle(
          color: redSoft,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      iconTheme: IconThemeData(
        color: blueLight,
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: redSoft,
        unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.65),
        indicatorColor: redSoft,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? redSoft
              : colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? redSoft.withValues(alpha: 0.45)
              : colorScheme.surfaceContainerHighest;
        }),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: redStrong,
        foregroundColor: Colors.white,
      ),

      cardTheme: CardThemeData(
        elevation: 3,
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: brandBlue,
          foregroundColor: Colors.white,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: redSoft,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: blueLight,
          side: BorderSide(color: colorScheme.outline),
        ),
      ),
    );
  }

  Future<void> loadDarkModePrefs() async {
    final prefs = SharedPreferencesAsync();
    final mode = await prefs.getBool("darkMode");
    if (mode != null) {
      darkMode = mode;
      notifyListeners();
    }
  }

  Future<void> setDarkMode(bool mode) async {
    darkMode = mode;
    notifyListeners();
    final prefs = SharedPreferencesAsync();
    await prefs.setBool("darkMode", mode);
  }
}