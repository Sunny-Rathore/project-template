import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/core/app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();

ThemeData get theme => ThemeHelper().themeData();

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  final _appTheme = "lightCode";

  // A map of custom color themes supported by the app
  final Map<String, LightCodeColors> _supportedCustomColor = {'lightCode': LightCodeColors()};

  // A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {'lightCode': ColorSchemes.lightCodeColorScheme};

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme = _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: appTheme.background,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.urbanist(fontSize: 18.fSize, fontWeight: FontWeight.w500, color: appTheme.bodyText),

        bodyMedium: GoogleFonts.urbanist(fontSize: 16.fSize, fontWeight: FontWeight.w400, color: appTheme.bodyText),

        bodySmall: GoogleFonts.urbanist(fontSize: 14.fSize, fontWeight: FontWeight.w400, color: appTheme.bodyText),

        titleLarge: GoogleFonts.urbanist(fontSize: 26.fSize, fontWeight: FontWeight.w700, color: appTheme.bodyText),

        titleMedium: GoogleFonts.urbanist(fontSize: 22.fSize, fontWeight: FontWeight.w700, color: appTheme.bodyText),

        titleSmall: GoogleFonts.urbanist(fontSize: 18.fSize, fontWeight: FontWeight.w700, color: appTheme.bodyText),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 0,
        backgroundColor: appTheme.background,
      ),
      appBarTheme: AppBarTheme(
        toolbarHeight: 80.v,
        backgroundColor: appTheme.background,
        titleTextStyle: GoogleFonts.urbanist(fontSize: 20.fSize, fontWeight: FontWeight.w600, color: appTheme.bodyText),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static const lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  // App Colors

  Color get background => const Color(0XFF000000);

  Color get white => const Color(0xFFFFFFFF);

  // Common Colors
  Color get borderColor => Colors.white;

  Color get whiteCustom => Colors.white;

  Color get blackCustom => Colors.black;

  Color get transparent => Colors.transparent;

  Color get grey => Colors.grey;

  // Brand / Theme Colors
  Color get primary => const Color(0xFFD3FF55);

  Color get blue => const Color(0xFF00B0FF);

  Color get green => const Color(0xFF00FF88);

  Color get secondaryPurple => const Color(0xFF6A61F9);

  Color get accentPink => const Color(0xFFEE52E1);

  // Neutral Background Colors

  // Border / Divider Colors
  Color get borderLightGrey => const Color(0xFFE4E5E7);

  Color get borderGrey => const Color(0xFFDEDEDE);

  // Text Colors
  Color get textPrimary => const Color(0xFF1A1A1A);

  Color get textDarkGrey => const Color(0xFF4D4D4D);

  Color get textMediumGrey => const Color(0xFF7D7D7D);

  // Status Colors
  Color get successGreen => const Color(0xFF22C55E);

  Color get errorRed => const Color(0xFFEF4444);

  Color get warningYellow => const Color(0xFFFFC107);

  // Overlay Colors
  Color get overlayBlack10 => const Color(0x0F000000);

  Color get bodyText => const Color(0xFFFFFFFF);

  Color get title => const Color(0xFF1A1A1A);

  // textColor
  Color get textLight => const Color(0xFFCDCDCD);
  // Material Shades
  Color get grey100 => Colors.grey.shade100;

  Color get grey200 => Colors.grey.shade200;
}
