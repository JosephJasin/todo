import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' show join;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

//CHANGE ME IF(a new color is added)
const Map<String, Color> nameToColor = {
  'red': Colors.red,
  'cyan': Colors.cyan,
  'blue': Colors.blue,
  'green': Colors.green,
  'teal': Colors.teal,
  'amber': Colors.amber,
  'pink': Colors.pink,
  'purple': Colors.purple,
};

final Map<Color, String> colorToName =
    Map.fromIterables(nameToColor.values, nameToColor.keys);

class Settings extends ChangeNotifier {
  Color color;

  Settings({this.color = Colors.white}) {
    _load();
  }

  void changeAppColor(Color color) async {
    this.color = color;
    await _save(color);
    notifyListeners();
  }

  Future<void> _save(Color color) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File(join(directory.path, 'settings.txt'));
    print('path : ${file.path}');
    file.writeAsStringSync(jsonEncode(toJson(color)),
        encoding: Encoding.getByName('UTF-8'));
  }

  Future<void> _load() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File(join(directory.path, 'settings.txt'));

    if (file.existsSync()) {
      String source =
          file.readAsStringSync(encoding: Encoding.getByName('UTF-8'));
      fromJson(jsonDecode(source));
      notifyListeners();
    }
  }

  Map<String, dynamic> toJson(Color color) {
    return {'color': colorToName[color]};
  }

  void fromJson(Map<String, dynamic> json) {
    changeAppColor(nameToColor[json['color']]);
  }
}
