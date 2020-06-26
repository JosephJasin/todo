import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/notes.dart';
import '../routes/editNotePage.dart';

class NotePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  NotePage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Notes>(
      builder: (context, Notes builder, child) {
        return ListView.builder(
          itemCount: builder.notesLength,
          itemBuilder: (context, index) {
            return OpenContainer(
              closedElevation: 0,
              openElevation: 0,
              closedBuilder: (context, action) => NoteWidget(
                builder.notes[index],
              ),
              openBuilder: (context, action) => EditNotePage(
                row: builder.notes[index],
                scaffold: scaffoldKey,
              ),
            );
          },
        );
      },
    );
  }
}

extension on int {
  bool toBool() => this == 1;
}

extension on bool {
  int toInt() => this ? 1 : 0;
}

class NoteWidget extends StatelessWidget {
  final Note note;

  NoteWidget(Map<String, dynamic> row, {Key key})
      : note = Note.fromRow(row),
        assert(row != null),
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
          subtitle: Text(note.getFormatedDate),
          trailing: Checkbox(
            value: note.done.toBool(),
            onChanged: (value) {
              note.done = value.toInt();
              if (value) note.priority = 1;
              context.read<Notes>().update(note);
            },
          ),
        ),
      ),
    );
  }
}
