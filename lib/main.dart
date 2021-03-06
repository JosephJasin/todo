import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/notes.dart';
import 'models/settings.dart';

import 'routes/pages.dart';

import 'themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Color color;
  try {
    color = Color(prefs.getInt('color'));
  } catch (e) {
    color = Colors.indigo;
  }

  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.bottom,
    SystemUiOverlay.top,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Settings>(
            create: (context) => Settings(color: color)),
        ChangeNotifierProvider<Notes>(create: (context) => Notes()),
      ],
      child: Consumer<Settings>(
        builder: (context, Settings builder, child) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: builder.color,
            ),
          );

          return App(color: builder.color);
        },
      ),
    ),
  );
}

class App extends StatelessWidget {
  final Color color;

  const App({this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo',
      theme: Themes(themeColor: color).themeData,
      debugShowCheckedModeBanner: false,
      // routes: {
      //   'home':(context)=>HomePage(),
      // },
      home: HomePage(),
    );
  }
}
