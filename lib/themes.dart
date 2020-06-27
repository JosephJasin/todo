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
          sliderTheme: SliderThemeData(
            showValueIndicator: ShowValueIndicator.onlyForDiscrete,
            valueIndicatorColor:
                HSVColor.fromColor(themeColor).withValue(0.7).toColor(),
            activeTrackColor:
                HSVColor.fromColor(themeColor).withValue(0.7).toColor(),
            inactiveTrackColor:
                HSVColor.fromColor(themeColor).withSaturation(0.6).toColor(),
            trackShape: const RectangularSliderTrackShape(),
            trackHeight: 4.0,
            thumbColor:
                HSVColor.fromColor(themeColor).withSaturation(0.6).toColor(),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
            overlayColor: themeColor.withAlpha(32),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
            activeTickMarkColor:
                HSVColor.fromColor(themeColor).withValue(0.6).toColor(),
            inactiveTickMarkColor:
                HSVColor.fromColor(themeColor).withValue(0.6).toColor(),
          ),
          indicatorColor: Colors.red,
        );
}
