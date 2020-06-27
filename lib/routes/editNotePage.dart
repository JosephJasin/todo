part of pages;

///[EditNotePage] will be displayed when:
///The [FloatingActionButton] button in [HomePage] is clicked (Add a new Note to the [AppDatabase]).
///any [NoteWidget] is clicked (Edit a Note in the [AppDatabase]).
class EditNotePage extends StatelessWidget {
  ///[appBarTitle] = 'Add Note' if [Note] is [null]
  ///otherwise = 'Edit Note'.
  final String appBarTitle;

  final Note _note;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final reminderController = TextEditingController();

  ///[scaffold] key is used to display a [SnackBar] in [HomePage]
  ///when the note is saved only.
  final GlobalKey<ScaffoldState> scaffold;

  EditNotePage({
    Key key,
    Map<String, dynamic> row,
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
        title: Text(appBarTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => saveNote(context),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title')),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          const SizedBox(height: 10),
          DateAndTimePicker(
            _note,
            controller: reminderController,
          ),
          const SizedBox(height: 10),

          //[_note] is passed to [CustomSlider] to provide the value of [_note.priority].
          Text(' Priority ( higher is more important )'),
          CustomSlider(_note),

          //Clear & Save buttons.
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('Clear', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    titleController.text = '';
                    descriptionController.text = '';
                    reminderController.text = '';
                    _note.reminder = '';
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => saveNote(context),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomSlider extends StatefulWidget {
  final Note note;

  CustomSlider(this.note, {Key key})
      : assert(note != null),
        super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.note.priority.toDouble() ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Slider(
        min: 1,
        max: 5,
        divisions: 4,
        value: _value,
        onChanged: (value) => setState(() => _value = value),
        onChangeEnd: (value) => widget.note.priority = value.toInt(),
        label: '$_value',
      ),
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
    return TextField(
      readOnly: true,
      controller: widget.controller,
      onTap: showDateThanTime,
      decoration: InputDecoration(
        labelText: 'Remind me at',
        suffixIcon: const Icon(Icons.date_range),
      ),
    );
  }
}
