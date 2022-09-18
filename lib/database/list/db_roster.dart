import 'package:budget/model/roster.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBRoster {
  static const _nameDB = 'roster.db';
  static const _nameTable = 'rostertable';
  static Database? _database;
  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _nameDB);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $_nameTable(name TEXT);');
  }

  static Future<int> insert(Roster roster) async {
    final db = await database;
    return await db.insert(_nameTable, roster.toMap());
  }

  static Future<int> update(Roster newRoster, Roster editRoster) async {
    final db = await database;
    return await db.rawUpdate(
      'UPDATE $_nameTable SET name = ? WHERE name =?;',
      [newRoster.name, editRoster.name],
    );
  }

  static Future<int> deleteRosterTable() async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $_nameTable;');
  }

  static Future<int> delete(Roster roster) async {
    final db = await database;
    return await db.rawDelete(
      'DELETE FROM $_nameTable WHERE name =?;',
      [roster.name],
    );
  }

  static Future<List<Roster>> getList() async {
    final db = await database;
    var maps = await db.rawQuery('SELECT* FROM $_nameTable ORDER BY name ASC;');
    List<Roster> list =
        maps.isNotEmpty ? maps.map((e) => Roster.fromMap(e)).toList() : [];
    return list;
  }
}
