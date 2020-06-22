import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes/editNotePage.dart';
import 'routes/homePage.dart';

import 'themes.dart';

void main() {
  runApp(App());

  //AppDatabase.deleteAppDatabase();

  // AppDatabase.open();
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(
        <SystemUiOverlay>[SystemUiOverlay.top]);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.redTheme,
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home: EditNotePage(),
    );
  }
}
