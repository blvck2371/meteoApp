import 'package:flutter/material.dart';
import 'package:meteoapp/theme/appColors.dart';

class Apptheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Appcolors.primarycolorLight,
    scaffoldBackgroundColor: Appcolors.primarycolorLight,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.white,
      circularTrackColor: Appcolors.primarycolorLight,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(color: Colors.white, fontSize: 20),
    ),
    appBarTheme: AppBarTheme(backgroundColor: Appcolors.primarycolorLight),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 133, 39, 234),
    scaffoldBackgroundColor: const Color.fromARGB(255, 28, 48, 165),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 48, 169, 202),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.white,
      circularTrackColor: Appcolors.primarycolorLight,
    ),
  );
}
