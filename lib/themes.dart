import 'package:flutter/material.dart';

abstract class Themes {
  static final ThemeData redTheme = ThemeData(
    primaryColor: Colors.red,
    iconTheme: const IconThemeData(color: Colors.white, size: 25),
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
  );
}
