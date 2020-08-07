part of pages;

///Get a path that is visbile to the user.
Future<String> getVisiblePath(BuildContext context) async {
  final platform = Theme.of(context).platform;

  if (platform == TargetPlatform.android)
    return (await getExternalStorageDirectory()).path;
  else if (platform == TargetPlatform.iOS)
    //TODO: when compiling the code to IOS , make sure to make the files visible.
    return (await getApplicationDocumentsDirectory()).path;

  throw UnsupportedError('Only Android and iOS are supported.');
}

///Show a dialog to check if the user want to
///import a databese (return true)
///or not(return false)
Future<bool> showAlertDialog(BuildContext context) async {
  bool import = false;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
            'If you import a new notes , your old notes will be deleted'),
        actions: [
          FlatButton(
            child: const Text('Continue'),
            onPressed: () async {
              import = true;
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    },
  );

  return import;
}

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
            title: const Text(
              'Restart the app to apply all changes',
              style: const TextStyle(color: Colors.grey),
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

        //Export the database as txt file.
        Card(
          child: ListTile(
            title: const Text('Export the notes'),
            trailing: Icon(
              MdiIcons.export,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () async {
              final path = await getVisiblePath(context);
              final file = File(path + '/NotesDataBase.txt');
              await Permission.storage.request();

              try {
                await file.create();
                await file.writeAsString(
                  Provider.of<Notes>(context, listen: false).toCSV(),
                );

                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text('Your notes are saved at\n$path'),
                  ));
              } catch (e) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text('Access Denied'),
                  ));
              }
            },
          ),
        ),

        //Share
        Card(
          child: ListTile(
            title: const Text('Share notes as CSV'),
            trailing: Icon(
              Icons.share,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              Share.share(Provider.of<Notes>(context, listen: false).toCSV());
            },
          ),
        ),

        //Import The database from file
        Card(
          child: ListTile(
            title: const Text('Import notes from file'),
            trailing: Icon(
              MdiIcons.fileImport,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () async {
              bool import = await showAlertDialog(context);

              if (import == false) return;

              Permission.storage.request();

              final file = await FilePicker.getFile();
              String notesCSV;
              try {
                final fileExtension =
                    file.path.substring(file.path.lastIndexOf('.') + 1);

                if (fileExtension == 'txt' || fileExtension == 'csv') {
                  notesCSV = await file.readAsString();

                  final result =
                      await Provider.of<Notes>(context, listen: false)
                          .fromCSV(notesCSV);

                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(result
                          ? 'Notes have been imported successfully'
                          : 'The file is not a valied file\nsee the help section for more info'),
                    ));
                } else {
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(
                          'The extension of the file must be .txt or .csv'),
                    ));
                }
              } catch (e) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text('Access Denied'),
                  ));
              }
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
                    bool import = await showAlertDialog(context);

                    if (import == false) return;

                    final result =
                        await Provider.of<Notes>(context, listen: false)
                            .fromCSV(importController.text);

                    Scaffold.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text(result
                            ? 'Notes have been imported successfully'
                            : 'The text is not a valied CSV text\nsee the help section for more info'),
                      ));

                    if (result) importController.text = '';
                  },
                ),
                labelText: 'Import the notes as CSV',
                hintText: 'id,priority,title,description,reminder\\n',
              ),
            ),
          ),
        ),

        //Manage permissions
        Card(
          child: ListTile(
            title: Text('Manage permissions'),
            trailing: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              openAppSettings();
            },
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
  Colors.pink,
  Colors.amber,
  Colors.cyan,
  Colors.blue,
  Colors.green,
  Colors.teal,
  Colors.indigo,
  Colors.deepPurpleAccent,
  Colors.purple,
  Colors.blueGrey,
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
