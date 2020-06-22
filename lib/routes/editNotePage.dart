import 'package:flutter/material.dart';

import 'package:NotesAndGoals/tools/note.dart';

class EditNotePage extends StatelessWidget {
  final String appBarTitle;
  double priority = 1;
  final dateController = TextEditingController();

  EditNotePage({Key key, Note note})
      : appBarTitle = note == null ? 'Add Note' : 'Edit Note',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: const TextField(
              decoration: InputDecoration(labelText: 'Title'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: const TextField(
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Remind me at',
                suffixIcon: IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () async {
                    DateTime lastDate = DateTime.tryParse(dateController.text);

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
                      dateController.text =
                          '${date.year}-${date.month < 10 ? 0 : ''}${date.month}-${date.day < 10 ? 0 : ''}${date.day} ${date.hour}:${date.minute}';
                  },
                ),
              ),
            ),
          ),
          Text('Priority'),
          Padding(
              padding: EdgeInsets.all(10),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Slider(
                    min: 1,
                    max: 5,
                    divisions: 5,
                    
                   // label: 'Priority',
                    value: priority,
                    onChanged: (value) {
                      setState(() {
                        priority = value;
                      });
                    },
                  );
                },
              ))
        ],
      ),
    );
  }
}
