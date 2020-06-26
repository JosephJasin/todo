import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'appDatabase.dart';
import 'models/notes.dart';
import 'models/goals.dart';

import 'routes/homePage.dart';

import 'themes.dart';

void main() async {
  runApp(App());
  //await AppDatabase.open();

  //await AppDatabase.deleteAppDatabase();

  //await AppDatabase.diplayTable('notes');
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Notes>(create: (context) => Notes()),
        ChangeNotifierProvider<Goals>(create: (context) => Goals()),
      ],
      child: MaterialApp(
        theme: Themes.redTheme,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
