import 'package:flutter/material.dart';

class Themes {
  final Color themeColor;
  final ThemeData themeData;

  Themes({this.themeColor = Colors.red})
      : themeData = ThemeData(
          primaryColor: themeColor,
          accentColor: themeColor,
          cursorColor: themeColor,
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            bodyText2: const TextStyle(fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white, size: 25),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(elevation: 0),
          tabBarTheme: TabBarTheme(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: themeColor,
            unselectedLabelColor: Colors.white,
            indicator: const BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10)),
                color: Colors.white),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: themeColor,
            foregroundColor: Colors.white,
            splashColor: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeColor),
            ),
          ),
          indicatorColor: Colors.red,

          //The color of [DatePicker]
          primarySwatch: MaterialColor(
            themeColor.value,
            <int, Color>{
              50: themeColor,
              100: themeColor,
              200: themeColor,
              300: themeColor,
              400: themeColor,
              500: themeColor,
              600: themeColor,
              700: themeColor,
              800: themeColor,
              900: themeColor,
            },
          ),
          dividerColor: Colors.white,
        );
}
