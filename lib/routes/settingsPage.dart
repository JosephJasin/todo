part of pages;

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        //Alert
        ListTile(
          trailing: Icon(
            Icons.priority_high,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Restart the app to apply all changes',
            style: TextStyle(color: Colors.grey),
          ),
        ),

        //Color
        ListTile(
          title: const Text('App Color'),
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

        //import
        ,
        ListTile(
          title: Text('Import a database'),
          trailing: Icon(
            MdiIcons.import,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

///CHANGE ME IF(you want to add a new color).
const List<Color> colors = [
  Colors.red,
  Colors.cyan,
  Colors.blue,
  Colors.green,
  Colors.teal,
  Colors.amber,
  Colors.pink,
  Colors.purple,
];

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text('Choose a color'),
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
          child: Text('Back'),
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
