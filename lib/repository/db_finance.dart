import 'package:budget/screen2/const/db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DBFinance {
  static Database? _database;

  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'finance.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute(DBTableOperations.createTable());
    await db.rawInsert(DBTableOperations.insertTable());
    await db.execute(DBTableCategories.createTable());
    await db.rawInsert(DBTableCategories.insertTable());
    await db.execute(DBTableSubCategories.createTable());
    await db.rawInsert(DBTableSubCategories.insertTable());
  }

  //Запись в БД
  static Future<int> insert(String table, Map<String, Object?> values) async {
    final db = await database;
    return await db.insert(table, values);
  }

  //Получить данные
  static Future<List<Map<String, Object?>>> rawQuery(String sql,
      [List<Object?>? arguments]) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }

  //Обновить данные
  static Future rawUpdate(String sql, [List<Object?>? arguments]) async {
    final db = await database;
    await db.rawUpdate(sql, arguments);
  }
}






/*
WHERE some_column IS NULL OR some_column = '';



  Чтение
  static Future<List<Finance>> getListFinance(String table) async {
    final Database db = await database;
    final maps = await db.query(table);
    return maps.isNotEmpty ? maps.map((e) => Finance.fromMap(e)).toList() : [];
  }

 //Лист категорий для screen_home
  static Future<List<Category>> getListCategory(String table) async {
    final Database db = await database;
    final maps = await db.rawQuery('''
      SELECT category as name, SUM(value) as value, IFNULL( SUM(value)/(SELECT SUM(value) FROM $table)*100.0, 0.0) as percent ,color
      FROM $table
      GROUP BY category, color
      ORDER BY value DESC;


        ''');

    return maps.isNotEmpty ? maps.map((e) => Category.fromMap(e)).toList() : [];
  }

  //Лист Подкатегорий для screen_category
  static Future<List<SubCategory>> getListSubCategory(
      String table, Category category) async {
    final Database db = await database;
    final maps = await db.rawQuery('''
      SELECT subcategory as name, SUM(value) as value, IFNULL( SUM(value)/(SELECT SUM(value) FROM $table)*100.0, 0.0) as percent ,color, comment
      FROM $table
      WHERE category = ?
      GROUP BY subcategory, color
      ORDER BY value DESC;


        ''', [category.name]);

    return maps.isNotEmpty
        ? maps.map((e) => SubCategory.fromMap(e)).toList()
        : [];
  }

  //Лист Операций для screen_SubCategory
  static Future<List<Operation>> getListOperations(
      String table, Category category, SubCategory subCategory) async {
    final Database db = await database;
    final maps = await db.rawQuery('''
      SELECT date, value, comment, color
      FROM $table
      WHERE category = ? AND subcategory = ?
      ORDER BY date DESC;
        ''', [category.name, subCategory.name]);

    return maps.isNotEmpty
        ? maps.map((e) => Operation.fromMap(e)).toList()
        : [];
  }
*/