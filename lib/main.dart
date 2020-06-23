import 'package:NotesAndGoals/tools/appDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes/editNotePage.dart';
import 'routes/homePage.dart';

import 'themes.dart';

void main() {
  runApp(App());

  // AppDatabase.deleteAppDatabase();

  //AppDatabase.open();

  AppDatabase.diplayTable('notes');
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
      <SystemUiOverlay>[
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.redTheme,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
