import 'package:NotesAndGoals/tools/appDatabase.dart';
import 'package:NotesAndGoals/tools/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: AppDatabase.getTableRows('notes', orderBy: 'priority DESC'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Note note = Note.fromRow(snapshot.data[index]);
              return NoteWidget(note);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class NoteWidget extends StatelessWidget {
  final Note note;

  const NoteWidget(this.note, {Key key})
      : assert(note != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 2,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
          side: const BorderSide(color: Colors.grey),
        ),
        child: ListTile(
          title: Text(note.title),
          subtitle: Text(
              '${DateFormat('y/MMM/d').format(DateTime.parse(note.reminder))} , ${DateFormat.jm().format(DateTime.parse(note.reminder))}'),
          trailing: NoteWidgetCheckbox(note),
        ),
      ),
    );
    ;
  }
}

class NoteWidgetCheckbox extends StatefulWidget {
  final Note note;
  NoteWidgetCheckbox(this.note, {Key key})
      : assert(note != null),
        super(key: key);

  @override
  NoteWidgetCheckboxState createState() => NoteWidgetCheckboxState();
}

class NoteWidgetCheckboxState extends State<NoteWidgetCheckbox> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (newValue) => setState(() => value = newValue),
    );
  }
}
