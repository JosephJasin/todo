import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('App Color'),
          trailing: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              child: ColorPicker(),
            );
          },
        )
      ],
    );
  }
}

List<Color> colors = colorToName.keys.toList();

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose  color'),
      content: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(
            colors.length,
            (index) => ColorWidget(
                  color: colors[index],
                )),
      ),
      actions: <Widget>[
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

class ColorWidget extends StatelessWidget {
  final color;

  const ColorWidget({Key key, this.color = Colors.red}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<Settings>(context, listen: false).changeAppColor(color);
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
