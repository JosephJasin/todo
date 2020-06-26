import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../tools.dart';
import '../appDatabase.dart';

class Note {
  int id, priority, done;
  String title, description, reminder;

  DateTime get getReminder {
    return DateTime.tryParse(reminder);
  }

  String get getFormatedDate {
    if (reminder.isNotEmpty)
      return DateFormat('y/MMM/d').format(getReminder) +
          ' , ' +
          DateFormat.jm().format(getReminder);
    else
      return '';
  }

  //CHANGE ME IF(a new proprity is added to the [Note])
  static const tableCreation = const Pair<String, String>(
      'notes',
      'id INTEGER PRIMARY KEY,' +
          'priority INTEGER,' +
          'done INTEGER,' +
          'title TEXT,' +
          'description TEXT,' +
          'reminder TEXT ');

//CHANGE ME IF(a new proprity is added to the [Note])
  Note({
    this.priority = 1,
    this.done = 0,
    this.title = '',
    this.description = '',
    this.reminder = '',
  });

//CHANGE ME IF(a new proprity is added to the [Note])
  Note.fromRow(Map<String, dynamic> row) {
    id = row['id'];
    priority = row['priority'];
    done = row['done'];
    title = row['title'];
    description = row['description'];
    reminder = row['reminder'];
  }

//CHANGE ME IF(a new proprity is added to the [Note])
  Map<String, dynamic> toRow() {
    return {
       'id': id,
      'priority': priority,
      'done': done,
      'title': title,
      'description': description,
      'reminder': reminder
    };
  }

//CHANGE ME IF(a new proprity is added to the [Note])
  void copyValuesFrom(Note note) {
    id = note.id;
    priority = note.priority;
    done = note.done;
    title = note.title;
    description = note.description;
    reminder = note.reminder;
  }
}

class Notes extends ChangeNotifier {
  List<Map<String, dynamic>> _notes;

  int notesLength = 0;

  List<Map<String, dynamic>> get notes => _notes;

  Notes() {
    _load();
  }

  Future<void> _load() async {
    _notes = await AppDatabase.getTableRows('notes');
    notesLength = _notes.length;
    notifyListeners();
  }

  Future<void> add(Note note) async {
    await AppDatabase.insertRow('notes', note.toRow());
    await _load();
    notifyListeners();
  }

  Future<void> update(Note note) async {
    await AppDatabase.updateRow('notes', note.toRow() ,where: 'id = ${note.id}');
    await _load();
    notifyListeners();
  }

  Future<void> remove(Note note) async {
    await AppDatabase.deleteRow('notes', 'id = ${note.id}');
    await _load();
    notifyListeners();
  }
}
