part of pages;

///[EditNotePage] will be displayed when:
///The [FloatingActionButton] button in [HomePage] is clicked (Add a new Note to the [AppDatabase]).
///any [NoteWidget] is clicked (Edit a Note in the [AppDatabase]).
class EditNotePage extends StatelessWidget {
  ///[appBarTitle] = 'Add Note' if [row] is [null]
  ///otherwise = 'Edit Note'.
  final String appBarTitle;

  final Note _note;
  final Map<String, dynamic> row;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final reminderController = TextEditingController();

  ///[scaffold] key is used to display a [SnackBar] in [HomePage]
  ///when the note is saved only.
  final GlobalKey<ScaffoldState> scaffold;

  EditNotePage({
    Key key,
    this.row,
    this.scaffold,
  })  : appBarTitle = row == null ? 'Add Note' : 'Edit Note',
        _note = row == null ? Note() : Note.fromRow(row),
        super(key: key) {
    titleController.text = _note.title;
    descriptionController.text = _note.description;
    reminderController.text = _note.getFormatedDate;
  }
  Future<void> saveNote(BuildContext context) async {
    Notes builder = context.read<Notes>();

    _note
      ..title = titleController.text
      ..description = descriptionController.text;

    if (appBarTitle == 'Add Note')
      await builder.add(_note);
    else
      await builder.update(_note);

    Navigator.pop(context);

    scaffold?.currentState?.showSnackBar(
      SnackBar(
        content: Text('Saved'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(appBarTitle,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          if (row != null)
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.delete_forever),
              onPressed: () async {
                await showDialog(
                  context: context,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text('Do you want to delete this note ?'),
                    actions: [
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Yes'),
                        onPressed: () async {
                          await Provider.of<Notes>(context, listen: false)
                              .remove(_note);
                          Navigator.of(context)..pop()..pop();
                        },
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          if (row != null) SizedBox(width: 5),
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () => saveNote(context),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          ColoredBox(
            color: whiteGreyColor,
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
          ),
          const SizedBox(height: 10),
          ColoredBox(
            color: whiteGreyColor,
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          const SizedBox(height: 10),
          DateAndTimePicker(
            _note,
            controller: reminderController,
          ),
          const SizedBox(height: 10),

          //[_note] is passed to [CustomSlider] to provide the value of [_note.priority].
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Priority',
              style: TextStyle(fontSize: 17),
            ),
          ),
          MyToggleButtons(_note),
        ],
      ),
    );
  }
}

class MyToggleButtons extends StatefulWidget {
  final Note note;

  MyToggleButtons(this.note, {Key key})
      : assert(note != null),
        super(key: key);
  @override
  _MyToggleButtonsState createState() => _MyToggleButtonsState();
}

class SelectedButton extends StatelessWidget {
  final bool isEnabled;
  final Color disabledColor;
  final String label;
  final IconData iconData;
  final int index;
  final Function(int index) setValue;

  const SelectedButton({
    Key key,
    @required this.index,
    @required this.setValue,
    @required this.iconData,
    this.label = '',
    this.isEnabled = false,
    this.disabledColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(width: 1, color: Colors.grey),
      ),
      color: isEnabled ? Theme.of(context).primaryColor : Colors.white,
      icon: Icon(
        iconData,
        color: isEnabled ? Colors.white : disabledColor,
      ),
      label: Text(
        label,
        style: TextStyle(color: isEnabled ? Colors.white : Colors.black),
      ),
      onPressed: () => setValue(index),
    );
  }
}

class _MyToggleButtonsState extends State<MyToggleButtons> {
  List<bool> _values = [false, false, false];

  void setValue(int index) {
    setState(() {
      _values = [false, false, false];
      _values[index] = true;
      widget.note.priority = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _values[widget.note.priority] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SelectedButton(
            isEnabled: _values[0],
            iconData: Icons.spa,
            index: 0,
            disabledColor: greenColor,
            setValue: setValue,
            label: 'Low',
          ),
        ),
        VerticalDivider(
          width: 10,
        ),
        Expanded(
          child: SelectedButton(
            isEnabled: _values[1],
            iconData: MdiIcons.alertOctagonOutline,
            index: 1,
            disabledColor: yellowColor,
            setValue: setValue,
            label: 'Medium',
          ),
        ),
        VerticalDivider(
          width: 10,
        ),
        Expanded(
          child: SelectedButton(
            isEnabled: _values[2],
            iconData: Icons.whatshot,
            index: 2,
            disabledColor: redColor,
            setValue: setValue,
            label: 'High',
          ),
        ),
      ],
    );
  }
}

///Pick a Date & Time for [note.reminder].
class DateAndTimePicker extends StatefulWidget {
  final Note note;
  final TextEditingController controller;

  DateAndTimePicker(
    this.note, {
    Key key,
    TextEditingController controller,
  })  : assert(note != null),
        this.controller = controller ?? TextEditingController(),
        super(key: key);

  @override
  _DateAndTimePickerState createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<DateAndTimePicker> {
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.note.getReminder ?? DateTime.now();
  }

  Future<void> showDateThanTime() async {
    //If the user click the cancel button , the value of [tempDate] will be [null].
    final DateTime tempDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (tempDate == null) return;

    //If the user click the cancel button , the value of [tempTime] will be [null].
    TimeOfDay tempTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: selectedDate.hour,
        minute: selectedDate.minute,
      ),
    );

    if (tempTime == null) return;

    selectedDate = DateTime(
      tempDate.year,
      tempDate.month,
      tempDate.day,
      tempTime.hour,
      tempTime.minute,
    );

    widget.note.reminder = selectedDate.toString();

    setState(() {
      widget.controller.text = widget.note.getFormatedDate;
    });
  }

  Widget build(BuildContext context) {
    return ColoredBox(
      color: whiteGreyColor,
      child: TextField(
        readOnly: true,
        controller: widget.controller,
        onTap: showDateThanTime,
        decoration: InputDecoration(
          labelText: 'Remind me at',
          suffixIcon: const Icon(Icons.date_range),
        ),
      ),
    );
  }
}
