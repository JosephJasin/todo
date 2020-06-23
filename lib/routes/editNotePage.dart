import 'package:NotesAndGoals/widgets/customSlider.dart';
import 'package:flutter/material.dart';

import 'package:NotesAndGoals/tools/appDatabase.dart';
import 'package:NotesAndGoals/tools/note.dart';

///[EditNotePage] will be displayed when:
///The [FloatingActionButton] button in [HomePage] is clicked (Add a new Note to the [AppDatabase]).
///any [NoteWidget] is clicked (Edit a Note in the [AppDatabase]).
class EditNotePage extends StatelessWidget {
  ///[appBarTitle] = 'Add Note' if [Note] is [null]
  ///otherwise = 'Edit Note'.
  final String appBarTitle;

  final Note _note = Note();

  final TextEditingController titleController,
      descriptionController,
      reminderController;

  ///[scaffold] key is used to display a [SnackBar] in [HomePage]
  ///when the note is saved only.
  final GlobalKey<ScaffoldState> scaffold;

  EditNotePage({Key key, Note note, this.scaffold})
      : appBarTitle = note == null ? 'Add Note' : 'Edit Note',
        titleController = TextEditingController(text: note?.title),
        descriptionController = TextEditingController(text: note?.description),
        reminderController = TextEditingController(text: note?.reminder),
        super(key: key);

  Future<void> saveNote(BuildContext context) async {
    _note
      ..title = titleController.text
      ..description = descriptionController.text
      ..reminder = reminderController.text;

    if (appBarTitle == 'Add Note')
      await AppDatabase.insertRow('notes', _note.toRow());
    else
      await AppDatabase.updateRow('notes', _note.toRow());

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
          TextField(
            controller: reminderController,
            decoration: InputDecoration(
              labelText: 'Remind me at',
              suffixIcon: IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () async {
                  DateTime lastDate =
                      DateTime.tryParse(reminderController.text);

                  DateTime date = await showDatePicker(
                    context: context,
                    initialDate: lastDate == null ? DateTime.now() : lastDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  TimeOfDay time = await showTimePicker(
                      context: context,
                      initialTime: lastDate == null
                          ? TimeOfDay.now()
                          : TimeOfDay.fromDateTime(lastDate));

                  try {
                    date = date.add(
                        Duration(hours: time?.hour, minutes: time?.minute));
                  } catch (_) {}

                  if (date != null)
                    reminderController.text =
                        '${date.year}-${date.month < 10 ? 0 : ''}${date.month}-${date.day < 10 ? 0 : ''}${date.day} ${date.hour}:${date.minute}';
                },
              ),
            ),
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
