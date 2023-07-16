import 'package:budget/const/db.dart';
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
    await db.execute(DBTableFinance.createTable());
    await db.rawInsert(DBTableFinance.insertTable());
    await db.execute(DBTableCategories.createTable());
    await db.rawInsert(DBTableCategories.insertTable());
    await db.execute(DBTableSubCategories.createTable());
    await db.rawInsert(DBTableSubCategories.insertTable());
    await db.execute(DBTableOperations.createTable());
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

  //Удалить данные
  static Future rawDelete(String sql, [List<Object?>? arguments]) async {
    final db = await database;
    await db.rawDelete(sql, arguments);
  }
}
