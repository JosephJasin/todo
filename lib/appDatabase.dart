import 'package:sqflite/sqflite.dart';

import 'models/notes.dart' show Note;

///Access a database and perform the CRUD operations.
class AppDatabase {
  static const String _name = 'AppDatabase.db';
  static Database _database;

  static String get path => _database?.path;

  ///Open the database if exits otherwise create it.
  static Future<void> open({int version = 1}) async {
    _database ??= await openDatabase(
      _name,
      version: version,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE notes (${Note.tableCreation})');
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
  static Future<int> insertRow(Map<String, dynamic> values) async {
    await open();
    return await _database.insert('notes', values);
  }

  ///Edit a row in any table.
  ///if [where] is null , all the rows in the values will be updated.
  static Future<int> updateRow(Map<String, dynamic> values,
      {String where}) async {
    await open();
    return await _database.update('notes', values, where: where);
  }

  ///Delete a row in a table.
  ///if [where] is null , all the rows will be deleted.
  static Future<int> deleteRow(String where) async {
    await open();
    return _database.delete('notes', where: where);
  }

  static Future<void> deleteAllRows() async {
    await _database.delete('notes', where: '1');
  }

  static Future<List<Map<String, dynamic>>> getTableRows(
      {String orderBy = 'priority DESC'}) async {
    await open();

    return await _database.query('notes', orderBy: orderBy);
  }

  static Future<Map<String, dynamic>> getRow(int id) async {
    return (await _database.query('notes', where: 'id = $id')).first;
  }
}
