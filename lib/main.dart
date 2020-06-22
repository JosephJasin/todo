import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routs/homePage.dart';
import 'themes.dart';
void main() async => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.redTheme,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // home: EditPage(),
    );
  }
}
