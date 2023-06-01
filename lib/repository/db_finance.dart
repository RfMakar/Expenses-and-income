import 'package:budget/model/category.dart';
import 'package:budget/model/finance.dart';
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
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
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
  static Future<void> insert(String table, Finance finance) async {
    final db = await database;
    await db.insert(table, finance.toMap());
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

  //Чтение
  // static Future<List<Finance>> getListFinance(String table) async {
  //   final Database db = await database;
  //   final maps = await db.query(table);
  //   return maps.isNotEmpty ? maps.map((e) => Finance.fromMap(e)).toList() : [];
  // }
}

//WHERE some_column IS NULL OR some_column = '';