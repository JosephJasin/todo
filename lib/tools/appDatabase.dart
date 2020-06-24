import 'dart:io' show File;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:NotesAndGoals/tools/note.dart';

///Sqelite built-in types.
abstract class Types {
  static const INTEGER = 'INTEGER';
  static const REAL = 'REAL';
  static const TEXT = 'TEXT';
  static const NULL = 'NULL';
}

///Access a database and perform the CRUD operations on any table
class AppDatabase {
  static String _name = 'AppDatabase.db';
  static Database _database;

  ///WARNING: any change in the tables must be applied to Note & Goal classes.
  ///The tables of the database.
  ///``` {
  ///   'table1' : {
  ///   'column1' : 'Sqelite built-in types',
  ///   'column2' : 'Sqelite built-in types'...
  ///   },
  ///
  ///   'table2' : {
  ///   'column1' : 'Sqelite built-in types',
  ///   'column2' : 'Sqelite built-in types',
  ///   'column3' : 'Sqelite built-in types'
  ///   },
  ///   ...
  /// }
  /// ```
  static const Map<String, Map<String, String>> _tables = {
    'notes': {
      'id': Types.INTEGER + " PRIMARY KEY",
      'priority': Types.INTEGER,
      'done': Types.INTEGER,
      'title': Types.TEXT,
      'description': Types.TEXT,
      'reminder': Types.TEXT,
    },
    'goals': {
      'id': Types.INTEGER + " PRIMARY KEY",
      'priority': Types.INTEGER,
      'title': Types.TEXT,
      'description': Types.TEXT,
      'tasks': Types.TEXT,
      'startDate': Types.TEXT,
      'endDate': Types.TEXT,
      'reminder': Types.TEXT,
    }
  };

  ///Open the database if exits otherwise create it.
  static Future<void> open({int version = 1}) async {
    _database ??= await openDatabase(_name, version: version,
        onCreate: (db, version) async {
      _tables.forEach((table, columns) async {
        String columnsNameAndType = "";
        columns.forEach((name, type) {
          if (columnsNameAndType.isNotEmpty) columnsNameAndType += ' , ';
          columnsNameAndType += name + " " + type;
        });
        await db.execute('CREATE TABLE $table ($columnsNameAndType)');
      });
    });
  }

  ///Close the database if the database if open.
  static Future<void> close() async {
    if (_database != null && _database.isOpen) _database.close();
  }

  ///Delete the database.
  static Future<void> deleteAppDatabase() async {
    String path = join(await getDatabasesPath(), _name);
    if (await File(path).exists()) await File(path).delete();

    // await open();
    // await deleteDatabase(_database.path);
  }

  ///Add one row to any table.
  static Future<void> insertRow(
      String table, Map<String, dynamic> values) async {
    await open();

    if (_tables.containsKey(table)) await _database.insert(table, values);
  }

  ///Edit a row in any table.
  ///if [where] is null , all the rows in the values will be updated.
  static Future<void> updateRow(String table, Map<String, dynamic> values,
      {String where}) async {
    await open();
    if (_tables.containsKey(table))
      await _database.update(table, values, where: where);
  }

  ///Delete a row in a table.
  ///if [where] is null , all the rows will be deleted.
  static Future<void> deleteRow(String table, String where) async {
    await open();

    if (_tables.containsKey(table)) await _database.delete(table, where: where);
  }

  //TEMP:REMOVE THIS METHOD AFTER TESTING
  static Future<void> diplayTable(String table) async {
    await open();

    if (_tables.containsKey(table)) {
      (await _database.query(table)).forEach((element) {
        element.forEach((key, value) {
          print('$value,');
        });

        print('');
      });
    }
  }

  static Future<List<Map<String, dynamic>>> getTableRows(String table,
      {String orderBy}) async {
    await open();

    return _tables.containsKey(table)
        ? await _database.query(table, orderBy: orderBy)
        : null;
  }
}
