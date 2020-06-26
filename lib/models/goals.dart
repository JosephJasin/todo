/**
 * EDIT THIS CLASS BY LOOKING AT NOTE CLASS
 * 
 * 
 * 
 */

import 'package:flutter/foundation.dart';

import '../tools.dart';
import '../appDatabase.dart';

class Goal {
  int id, priority;
  String title, description, tasks, startDate, endDate, reminder;

  //CHANGE ME IF(a new proprity is added to the [Goal])
  ///get the table name [tableCreation.first], and the table columns [tableCreation.second].
  static const tableCreation = const Pair<String, String>(
      'goals',
      'id INTEGER PRIMARY KEY,' +
          'priority INTEGER,' +
          'title TEXT,' +
          'description TEXT,' +
          'tasks TEXT,' +
          'startDate TEXT,' +
          'endDate TEXT,' +
          'reminder TEXT');

  //CHANGE ME IF(a new proprity is added to the [Goal])
  Goal({
    this.priority = 1,
    this.title = '',
    this.description = '',
    this.tasks = '',
    this.startDate = '',
    this.endDate = '',
    this.reminder = '',
  });

  //CHANGE ME IF(a new proprity is added to the [Goal])
  Goal.fromRow(Map<String, dynamic> row) {
    id = row['id'];
    priority = row['priority'];
    title = row['title'];
    description = row['description'];
    tasks = row['tasks'];
    startDate = row['startDate'];
    endDate = row['endDate'];
    reminder = row['reminder'];
  }

  //CHANGE ME IF(a new proprity is added to the [Goal])
  Map<String, dynamic> toRow() {
    return {
      'id': id,
      'priority': priority,
      'title': title,
      'description': description,
      'tasks': tasks,
      'startDate': startDate,
      'endDate': endDate,
      'reminder': reminder
    };
  }
}

class Goals extends ChangeNotifier {
  List<Map<String, dynamic>> _goals;
  int goalsLength = 0;

  List<Map<String, dynamic>> get goals => _goals;

  Goals() {
    AppDatabase.getTableRows('goals').then(
      (value) {
        _goals = value;
        goalsLength = _goals.length;
        notifyListeners();
      },
    );
  }

  Future<void> add(Goal goal) async {
    await AppDatabase.insertRow('goals', goal.toRow());
    notifyListeners();
  }

  Future<void> update(Goal goal) async {
    await AppDatabase.updateRow('goals', goal.toRow());

    notifyListeners();
  }

  Future<void> remove(Goal goal) async {
    await AppDatabase.deleteRow('goals', 'id = ${goal.id}');
    notifyListeners();
  }
}
