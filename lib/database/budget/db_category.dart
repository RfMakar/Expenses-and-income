import 'package:budget/model/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBCategory {
  static Database? _database;

  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'category.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE expcattab(name TEXT, color INTEGER);');
    await db.execute('CREATE TABLE inccattab(name TEXT, color INTEGER);');
  }

  static Future<int> insert(String table, Category category) async {
    final db = await database;
    return await db.insert(table, category.toMapCategory());
  }

  static Future<int> update(
      String table, Category categoryNew, Category category) async {
    final db = await database;
    return await db.rawUpdate(
        'UPDATE $table SET name = ?, color = ? WHERE name =? AND color = ?; ',
        [categoryNew.name, categoryNew.color, category.name, category.color]);
  }

  static Future<int> delete(String table, Category category) async {
    final db = await database;
    return await db.rawDelete(
        'DELETE FROM $table WHERE name =? AND color  = ?;',
        [category.name, category.color]);
  }

  static Future<int> deletCategoryTable(String table) async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $table;');
  }

  static Future<List<Category>> getList(String table) async {
    final db = await database;
    var maps = await db.rawQuery(' SELECT* FROM $table ORDER BY name ASC;');
    List<Category> list = maps.isNotEmpty
        ? maps.map((e) => Category.fromMapCategory(e)).toList()
        : [];
    return list;
  }

  static Future<bool> checkCatName(String table, Category category) async {
    final db = await database;
    var maps = await db
        .rawQuery('SELECT* FROM $table WHERE name = ?;', [category.name]);

    return maps.isNotEmpty;
  }
}
