import 'package:flutter/material.dart';
import 'package:meteoapp/theme/appColors.dart';

class Apptheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Appcolors.primarycolorLight,
    scaffoldBackgroundColor: Appcolors.primarycolorLight,
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
    primaryColor: Appcolors.primarycolorLight,
    scaffoldBackgroundColor: Appcolors.primarycolorLight,
  );
}
