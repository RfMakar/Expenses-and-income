import 'package:budget/model/account.dart';
import 'package:budget/model/category.dart';
import 'package:budget/model/finance.dart';
import 'package:budget/model/operation.dart';
import 'package:budget/model/subcategory.dart';
import 'package:budget/screen2/const/db_table.dart';
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
      version: 2,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DBTable.account}(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT NOT NULL,
          color TEXT NOT NULL
          );
      ''');
    await db.execute('''
      CREATE TABLE ${DBTable.expenses}(
          date TEXT,
          category TEXT,
          subcategory TEXT,
          value REAL,
          comment TEXT,
          color TEXT
          );
      ''');
  }

  //Запись в БД
  static Future<void> insert(String table, Map<String, Object?> values) async {
    final db = await database;
    await db.insert(table, values);
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

  //Чтение
  // static Future<List<Finance>> getListFinance(String table) async {
  //   final Database db = await database;
  //   final maps = await db.query(table);
  //   return maps.isNotEmpty ? maps.map((e) => Finance.fromMap(e)).toList() : [];
  // }
}

//WHERE some_column IS NULL OR some_column = '';