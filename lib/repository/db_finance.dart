import 'package:budget/models/categories.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/models/operations.dart';
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
    await db.execute('''
    CREATE TABLE ${TableDB.finance}(
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
    );
    ''');
    await db.rawInsert('''
    INSERT INTO ${TableDB.finance}(id, name) VALUES
    (0, 'Расход'),
    (1, 'Доход'); 
    ''');
    await db.execute('''
    CREATE TABLE ${TableDB.categories}(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idfinance INTEGER REFERENCES ${TableDB.finance} (id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    color TEXT NOT NULL
    );
    ''');
    await db.rawInsert('''
    INSERT INTO ${TableDB.categories} (idfinance, name, color) VALUES
    (0, 'Машина','4280391411'),
    (0, 'Продукты','4288585374'),
    (0, 'Развлечения','4294198070'),
    (0, 'Спорт','4284955319'),
    (0, 'Кафе','4280391411'),
    (0, 'Подарки','4284955319'),
    (1, 'Зарплата','4288585374'),
    (1, 'Вклад','4284955319'); 
    ''');
    await db.execute('''
    CREATE TABLE ${TableDB.subcategories}(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idcategory INTEGER REFERENCES ${TableDB.categories} (id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL
    );
    ''');
    await db.rawInsert('''
    INSERT INTO ${TableDB.subcategories}(idcategory, name) VALUES
    (1, 'ТО'),
    (1, 'Бензин'),
    (1, 'Запчасти'),
    (1, 'Мойка'); 
    ''');
    await db.execute('''
    CREATE TABLE ${TableDB.operations} (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idsubcategory INTEGER REFERENCES ${TableDB.subcategories} (id) ON DELETE CASCADE NOT NULL,
    date TEXT NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    value REAL NOT NULL,
    note TEXT NOT NULL
    );
    ''');
  }

  //Получить данные
  static Future<List<Category>> getListCategory(int finance) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
    SELECT id, name, color
    FROM ${TableDB.categories}
    WHERE idfinance = ?
    ORDER BY id DESC;
    ''',
      [finance],
    );
    return maps.isNotEmpty ? maps.map((e) => Category.fromMap(e)).toList() : [];
  }

  static Future<List<SubCategory>> getListSubCategory(Category category) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
    SELECT id, name
    FROM ${TableDB.subcategories}
    WHERE idcategory = ?
    ORDER BY id DESC
    ;
    ''',
      [category.id],
    );
    return maps.isNotEmpty
        ? maps.map((e) => SubCategory.fromMap(e)).toList()
        : [];
  }

  static Future<List<GroupCategory>> getListCategoryGroup(
      DateTime dateTime, int finance) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT ${TableDB.categories}.id AS id,
      ${TableDB.categories}.name AS name,
      ${TableDB.categories}.color AS color,
      ROUND(
        SUM(value)/(
          SELECT SUM(value) 
          FROM ${TableDB.operations} 
          JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
          JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory 
          WHERE year = ? AND month = ? AND ${TableDB.categories}.idfinance = ? 
        )*100.0, 1 ) as percent,
      ROUND(SUM(value), 1) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      WHERE year = ? AND month = ? AND ${TableDB.categories}.idfinance = ?
      GROUP BY ${TableDB.categories}.id
      ORDER BY value DESC
      ;
        ''',
      [
        dateTime.year,
        dateTime.month,
        finance,
        dateTime.year,
        dateTime.month,
        finance
      ],
    );
    return maps.isNotEmpty
        ? maps.map((e) => GroupCategory.fromMap(e)).toList()
        : [];
  }

  static Future<List<HistoryOperation>> getListHistoryOperation(
      DateTime dateTime, int finance) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT date,
      SUM(value) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ? AND month = ? AND ${TableDB.finance}.id = ?
      GROUP BY day
      ORDER BY day DESC
      ;
        ''',
      [dateTime.year, dateTime.month, finance],
    );
    return maps.isNotEmpty
        ? maps.map((e) => HistoryOperation.fromMap(e)).toList()
        : [];
  }

  static Future<List<Operation>> getListOperation(
      DateTime dateTime, int finance) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT ${TableDB.operations}.id AS id,
      ${TableDB.categories}.name AS namecategory,
      ${TableDB.subcategories}.name AS namesubcategory,
      note,
      date,
      value
      FROM ${TableDB.operations}
      JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ? AND month = ? AND day = ? AND ${TableDB.finance}.id = ? 
      ORDER BY id DESC
      ;
        ''',
      [dateTime.year, dateTime.month, dateTime.day, finance],
    );
    return maps.isNotEmpty
        ? maps.map((e) => Operation.fromMap(e)).toList()
        : [];
  }

  static Future<List<SumOperation>> getListSumOperation(
      DateTime dateTime, int finance) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT IFNULL( ROUND(SUM(value), 1),0.0) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory  
      WHERE year = ? AND month = ? AND ${TableDB.categories}.idfinance = ?
      ;
        ''',
      [dateTime.year, dateTime.month, finance],
    );
    return maps.isNotEmpty
        ? maps.map((e) => SumOperation.fromMap(e)).toList()
        : [];
  }

  //Запись в БД

  static Future<int> insertCategory(WriteCategory writeCategory) async {
    final db = await database;
    return await db.insert(TableDB.categories, writeCategory.toMap());
  }

  static Future<int> insertSubCategory(
      WriteSubCategory writeSubCategory) async {
    final db = await database;
    return await db.insert(TableDB.subcategories, writeSubCategory.toMap());
  }

  static Future<int> insertOperation(WriteOperation writeOperation) async {
    final db = await database;
    return await db.insert(TableDB.operations, writeOperation.toMap());
  }

  //Удалить данные

  static Future<int> deleteCategory(Category category) async {
    final db = await database;
    return await db.rawDelete('''
    DELETE
    FROM ${TableDB.categories} 
    WHERE id = ?;
    ''', [category.id]);
  }

  static Future<int> deleteSubCategory(SubCategory subCategory) async {
    final db = await database;
    return await db.rawDelete('''
    DELETE
    FROM ${TableDB.subcategories} 
    WHERE id = ?;
    ''', [subCategory.id]);
  }

  static Future<int> deleteOperation(Operation operation) async {
    final db = await database;
    return await db.rawDelete('''
    DELETE
    FROM ${TableDB.operations} 
    WHERE id = ?;
    ''', [operation.id]);
  }

  //Обновить данные

  static Future<int> updateCategoryName(
      String newName, Category category) async {
    final db = await database;
    return await db.rawUpdate('''
    UPDATE ${TableDB.categories} 
    SET name = ?
    WHERE id = ?;
    ''', [newName, category.id]);
  }

  static Future<int> updateCategoryColor(
      String color, Category category) async {
    final db = await database;
    return await db.rawUpdate(
      '''
    UPDATE ${TableDB.categories} 
    SET color = ?
    WHERE id = ?;
    ''',
      [color, category.id],
    );
  }

  static Future<int> updateSubCategoryName(
      String newName, SubCategory subCategory) async {
    final db = await database;
    return await db.rawUpdate('''
    UPDATE ${TableDB.subcategories} 
    SET name = ?
    WHERE id = ?;
    ''', [newName, subCategory.id]);
  }
}

class TableDB {
  static const finance = 'finance';
  static const categories = 'categories';
  static const subcategories = 'subcategories';
  static const operations = 'operations';
}
