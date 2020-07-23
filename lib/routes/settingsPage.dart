part of pages;

class SettingsPage extends StatelessWidget {
  final importController = TextEditingController();

  SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      children: <Widget>[
        //Alert
        Card(
          child: ListTile(
            trailing: Icon(
              Icons.priority_high,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Restart the app to apply all changes',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Divider(height: 5),

        //Color
        Card(
          child: ListTile(
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
          ),
        ),
        Divider(height: 5),

        //Export
        Card(
          child: ListTile(
            title: Text('Export the database as CSV'),
            trailing: Icon(
              MdiIcons.export,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    actions: [
                      FlatButton(
                        child: Text('Back'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('Copy'),
                        onPressed: () async {
                          await FlutterClipboard.copy(
                            Provider.of<Notes>(context, listen: false).toCSV() +
                                ' ',
                          );
                          Scaffold.of(context).showSnackBar(
                            const SnackBar(
                              content: const Text('Copied to Clipboard'),
                            ),
                          );
                        },
                      ),
                    ],
                    contentPadding: const EdgeInsets.only(left: 25, right: 25),
                    title: const Text(
                      "id,priority,title,description,reminder",
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    content: Container(
                      height: 200,
                      width: 300,
                      padding: EdgeInsets.only(top: 10),
                      child: SingleChildScrollView(
                        child: SelectableText(
                          Provider.of<Notes>(context, listen: false).toCSV(),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        //Import
        Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: importController,
              autocorrect: false,
              maxLines: null,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(MdiIcons.import),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (_context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: Text(
                                'If you import a database , your old notes will be deleted'),
                            actions: [
                              FlatButton(
                                child: Text('Import'),
                                onPressed: () async {
                                  Navigator.of(_context).pop();

                                  final result = await Provider.of<Notes>(
                                          context,
                                          listen: false)
                                      .fromCSV(importController.text);

                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        result
                                            ? 'The database have been imported :)'
                                            : 'Wrong CSV format :(',
                                      ),
                                    ),
                                  );
                                },
                              ),
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
                labelText: 'Import the database as CSV',
                hintText: 'id,priority,title,description,reminder\\n',
              ),
            ),
          ),
        ),
        Divider(height: 15),

        //Help
        Card(
          child: ListTile(
            title: Text('Help'),
            trailing: Icon(
              Icons.help_outline,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) {
                  return HelpPage();
                }),
              );
            },
          ),
        ),

        //Info
        Card(
          child: ListTile(
            title: Text('Info'),
            trailing: Icon(
              Icons.info_outline,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AboutDialog(
                      applicationName: 'Todo',
                    );
                  });
            },
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
  Color(0xff212121),
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
