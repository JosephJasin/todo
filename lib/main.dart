import 'package:flutter/material.dart';
import 'tools/appDatabase.dart';

void main() async {
  runApp(MaterialApp(
    home: MyApp(),
  ));

  await AppDatabase.open();
  // await AppDatabase.insertRow('notes', {
  //   'id' : null,
  //   'title' : 'title1',
  //   'description': 'descritption1',
  // });

  await AppDatabase.updateRow('notes', {'title': 'NEWTITLE3'});

  await AppDatabase.diplayTable('notes');
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
