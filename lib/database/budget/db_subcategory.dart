import 'package:budget/model/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBSubcategory {
  static Database? _database;

  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'subcategory.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE expsubcattab(name TEXT, subname TEXT,color INTEGER);');
    await db.execute(
        'CREATE TABLE incsubcattab(name TEXT, subname TEXT,color INTEGER);');
  }

  static Future<int> insert(String table, Category category) async {
    final db = await database;
    return await db.insert(table, category.toMapSubCategory());
  }

  static Future<int> update(
      String table, Category newCategory, Category editCategory) async {
    final db = await database;
    return await db.rawUpdate(
        'UPDATE $table SET name = ?, subname = ?, color = ? WHERE name =? AND subname = ? AND color = ?;',
        [
          newCategory.name,
          newCategory.subname,
          newCategory.color,
          editCategory.name,
          editCategory.subname,
          editCategory.color
        ]);
  }

  static Future<int> updateCategory(
      String table, Category newCategory, Category editCategory) async {
    final db = await database;
    return await db.rawUpdate(
        'UPDATE $table SET name = ?, color = ? WHERE name =? AND color = ?;', [
      newCategory.name,
      newCategory.color,
      editCategory.name,
      editCategory.color
    ]);
  }

  static Future<int> delete(String table, Category category) async {
    final db = await database;
    return await db.rawDelete(
        'DELETE FROM $table WHERE name =? AND subname = ? AND color  = ?;',
        [category.name, category.subname, category.color]);
  }

  static Future<int> deleteSubCategoryTable(String table) async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $table;');
  }

  static Future<int> deleteCategory(String table, Category category) async {
    final db = await database;
    return await db.rawDelete(
        'DELETE FROM $table WHERE name =? AND color  = ?;',
        [category.name, category.color]);
  }

  static Future<List<Category>> getList(String table, Category category) async {
    final db = await database;
    var maps = await db.rawQuery(
        'SELECT* FROM $table WHERE name = ? ORDER BY subname ASC;',
        [category.name]);
    List<Category> list = maps.isNotEmpty
        ? maps.map((e) => Category.fromMapSubCategory(e)).toList()
        : [];
    return list;
  }

  static Future<bool> checkCatSubName(String table, Category category) async {
    final db = await database;
    var maps = await db.rawQuery(
        '''SELECT* FROM $table WHERE subname = ?;''', [category.subname]);
    return maps.isNotEmpty;
  }
}
