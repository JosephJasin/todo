import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';


class Settings extends ChangeNotifier {
  Color color;

  Settings({this.color = Colors.red});

  void changeAppColor(Color color) async {
    this.color = color;
     _save();
    notifyListeners();
  }

  Future<void> _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('color', color.value);
  }
}
