import 'dart:io' show File;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

import 'tools.dart';

import 'models/notes.dart' show Note;
import 'models/goals.dart' show Goal;

///Check if a [Set<Pair>] contains a [Pair] with the [first] element.
extension on Set<Pair> {
  bool containsFirst(first) {
    for (Pair pair in this) {
      if (pair.first == first) return true;
    }
    return false;
  }
}

///Access a database and perform the CRUD operations on any table
class AppDatabase {
  static const String _name = 'AppDatabase.db';
  static Database _database;

  //CHANGE ME IF(the tables of the database changed).
  static const Set<Pair<String, String>> _tables = {
    Note.tableCreation,
    Goal.tableCreation,
  };

  ///Open the database if exits otherwise create it.
  static Future<void> open({int version = 1}) async {
    _database ??= await openDatabase(
      _name,
      version: version,
      onCreate: (db, version) async {
        _tables.forEach(
          (table) async =>
              await db.execute('CREATE TABLE ${table.first} (${table.second})'),
        );
      },
    );
  }

  ///Close the database if the database if open.
  static Future<void> close() async {
    if (_database != null && _database.isOpen) _database.close();
  }

  ///Delete the database.
  static Future<void> deleteAppDatabase() async {
    // String path = join(await getDatabasesPath(), _name);
    // if (await File(path).exists()) await File(path).delete();

    await open();
    await deleteDatabase(_database.path);
  }

  ///Add one row to any table.
  static Future<int> insertRow(
      String table, Map<String, dynamic> values) async {
    await open();

    if (_tables.containsFirst(table))
      return await _database.insert(table, values);
    else
      throw Exception('Wrong table name ($table)');
  }

  ///Edit a row in any table.
  ///if [where] is null , all the rows in the values will be updated.
  static Future<int> updateRow(String table, Map<String, dynamic> values,
      {String where}) async {
    await open();
    if (_tables.containsFirst(table))
      return await _database.update(table, values, where: where);
    else
      throw Exception('Wrong table name ($table)');
  }

  ///Delete a row in a table.
  ///if [where] is null , all the rows will be deleted.
  static Future<int> deleteRow(String table, String where) async {
    await open();

    if (_tables.containsFirst(table))
      return _database.delete(table, where: where);
    else
      throw Exception('Wrong table name ($table)');
  }

  //TEMP:REMOVE THIS METHOD AFTER TESTING
  static Future<void> diplayTable(String table) async {
    await open();

    if (_tables.containsFirst(table)) {
      (await _database.query(table)).forEach((element) {
        element.forEach((key, value) {
          print('$value,');
        });

        print('');
      });
    } else
      throw Exception('Wrong table name ($table)');
  }

  static Future<List<Map<String, dynamic>>> getTableRows(String table,
      {String orderBy = 'priority DESC'}) async {
    await open();

    return _tables.containsFirst(table)
        ? await _database.query(table, orderBy: orderBy)
        : null;
  }

  static Future<Map<String, dynamic>> getRow(String table, int id) async {
    return _tables.containsFirst(table)
        ? (await _database.query(table, where: 'id = $id')).first
        : null;
  }
}
