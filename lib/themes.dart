import 'package:flutter/material.dart';

abstract class Themes {
  static final ThemeData redTheme = ThemeData(
    primaryColor: Colors.red,
    accentColor: Colors.red,
    cursorColor: Colors.red,
    iconTheme: const IconThemeData(color: Colors.white, size: 25),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(elevation: 0),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.red,
      unselectedLabelColor: Colors.white,
      indicator: const BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10)),
          color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      splashColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.red[700],
      inactiveTrackColor: Colors.red[100],
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: Colors.redAccent,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
      overlayColor: Colors.red.withAlpha(32),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
    ),
  );
}

