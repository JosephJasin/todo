import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'appDatabase.dart';
import 'models/notes.dart';
import 'models/goals.dart';
import 'models/settings.dart';

import 'routes/homePage.dart';
import 'routes/editNotePage.dart';

import 'themes.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Settings>(create: (context) => Settings()),
        ChangeNotifierProvider<Notes>(create: (context) => Notes()),
        ChangeNotifierProvider<Goals>(create: (context) => Goals()),
      ],
      child: Consumer<Settings>(
        builder: (context, Settings builder, child) {
          return App(color: builder.color);
        },
      ),
    ),
  );
  //await AppDatabase.open();

  //await AppDatabase.deleteAppDatabase();

  //await AppDatabase.diplayTable('notes');
}

class App extends StatelessWidget {
  final Color color;
  const App({this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.top,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: color,
      ),
    );
    return MaterialApp(
      theme: Themes(themeColor: color).themeData,
      debugShowCheckedModeBanner: false,
      // routes: {
      //   'home':(context)=>HomePage(),
      // },
      home: HomePage(),
    );
  }
}
