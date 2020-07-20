import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show Color, Colors;

import 'package:shared_preferences/shared_preferences.dart';

///Control user preferences settings.
///
///[color] : app primary color.
class Settings extends ChangeNotifier {
  Color _color;

  Color get color => _color;

  Settings({Color color = Colors.red}) : _color = color;

  void changeAppColor(Color color) async {
    _color = color;
    _save();
    notifyListeners();
  }

  Future<void> _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('color', _color.value);
  }
}
