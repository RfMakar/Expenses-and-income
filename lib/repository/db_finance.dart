import 'package:budget/models/analitics.dart';
import 'package:budget/models/categories.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/models/operations.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TableDB {
  static const finance = 'finance';
  static const categories = 'categories';
  static const subcategories = 'subcategories';
  static const operations = 'operations';
}

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
    // await db.rawInsert('''
    // INSERT INTO ${TableDB.categories} (idfinance, name, color) VALUES
    // (0, 'Транспорт','4280391411'),
    // (0, 'Здоровье','4288585374'),
    // (0, 'Досуг','4294198070'),
    // (0, 'Продукты','4284955319'),
    // (0, 'Одежда и обувь','4280391411'),
    // (0, 'Образование','4284955319'),
    // (0, 'Автомобиль','4294198070'),
    // (0, 'Домашние животные','4280391411'),
    // (0, 'Квартира','4280391411'),
    // (1, 'Заработная плата','4288585374'),
    // (1, 'Ппроценты','4284955319'),
    // (1, 'Подарки','4284955319')
    // ;
    // ''');
    await db.execute('''
    CREATE TABLE ${TableDB.subcategories}(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idcategory INTEGER REFERENCES ${TableDB.categories} (id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL
    );
    ''');
    // await db.rawInsert('''
    // INSERT INTO ${TableDB.subcategories}(idcategory, name) VALUES
    // (1, 'Автобус'),
    // (1, 'Аренда'),
    // (1, 'Проездной'),
    // (1, 'Прочее'),
    // (1, 'Такси'),
    // (2, 'Лекарства'),
    // (2, 'Прочее'),
    // (2, 'Спортивные занятия'),
    // (2, 'Стоматология'),
    // (2, 'Страхование'),
    // (3, 'Игры'),
    // (3, 'Кинотеатры'),
    // (3, 'Книги'),
    // (3, 'Прочее'),
    // (3, 'Путешествия'),
    // (4, 'Молочные продукты'),
    // (4, 'Мясные продукты'),
    // (4, 'Овощи'),
    // (4, 'Прочее'),
    // (4, 'Фрукты'),
    // (5, 'Верхняя одежда'),
    // (5, 'Обувь'),
    // (5, 'Прочее'),
    // (5, 'Ремонт'),
    // (5, 'Спортивная одежда'),
    // (6, 'Книги'),
    // (6, 'Курсы'),
    // (6, 'Обучение'),
    // (6, 'Прочее'),
    // (7, 'Бензин'),
    // (7, 'Налог'),
    // (7, 'Прочее'),
    // (7, 'Ремонт'),
    // (7, 'Страхование'),
    // (8, 'Аксессуары'),
    // (8, 'Игрушки'),
    // (8, 'Корм'),
    // (8, 'Лечение'),
    // (8, 'Прочее'),
    // (9, 'Вода'),
    // (9, 'Интернет'),
    // (9, 'Отопление'),
    // (9, 'Прочее'),
    // (9, 'Электричество'),
    // (10, 'Аванс'),
    // (10, 'Премия'),
    // (10, 'Бонусы'),
    // (10, 'Отпускные'),
    // (10, 'Прочее'),
    // (11, 'Вклады'),
    // (11, 'Инвестиции'),
    // (11, 'Ценные бумаги'),
    // (11, 'Прочее'),
    // (12, 'Прочее')
    // ;
    // ''');
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
    ORDER BY name;
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
    ORDER BY name
    ;
    ''',
      [category.id],
    );
    return maps.isNotEmpty
        ? maps.map((e) => SubCategory.fromMap(e)).toList()
        : [];
  }

  static Future<List<GroupCategory>> getListGroupCategory(
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

  static Future<List<GroupSubCategory>> getListGroupSubCategory(
      DateTime dateTime, int finance, int idCategory) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT ${TableDB.subcategories}.id AS id,
      ${TableDB.subcategories}.name AS name,
      ROUND(
        SUM(value)/(
          SELECT SUM(value) 
          FROM ${TableDB.operations} 
          JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
          JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory 
          WHERE year = ? AND month = ? AND ${TableDB.categories}.idfinance = ? AND ${TableDB.subcategories}.idcategory = ? 
        )*100.0, 1 ) as percent,
      ROUND(SUM(value), 1) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      WHERE year = ? AND month = ? AND ${TableDB.categories}.idfinance = ? AND ${TableDB.subcategories}.idcategory = ? 
      GROUP BY ${TableDB.subcategories}.id
      ORDER BY value DESC
      ;
        ''',
      [
        dateTime.year,
        dateTime.month,
        finance,
        idCategory,
        dateTime.year,
        dateTime.month,
        finance,
        idCategory,
      ],
    );
    return maps.isNotEmpty
        ? maps.map((e) => GroupSubCategory.fromMap(e)).toList()
        : [];
  }

  static Future<List<HistoryOperation>> getListHistoryAllOperation(
      DateTime dateTime, int finance) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT date,
      ROUND(SUM(value),2) AS value
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

  static Future<List<HistoryOperation>> getListHistoryOperationCategory(
      DateTime dateTime, int finance, int idCategory) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT date,
      ROUND(SUM(value),2) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ? AND month = ? AND ${TableDB.finance}.id = ? AND ${TableDB.categories}.id = ? 
      GROUP BY day
      ORDER BY day DESC
      ;
        ''',
      [dateTime.year, dateTime.month, finance, idCategory],
    );
    return maps.isNotEmpty
        ? maps.map((e) => HistoryOperation.fromMap(e)).toList()
        : [];
  }

  static Future<List<HistoryOperation>> getListHistoryOperationSubCategory(
      DateTime dateTime, int finance, int idSubCategory) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT date,
      ROUND(SUM(value),2) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ? AND month = ? AND ${TableDB.finance}.id = ? AND ${TableDB.subcategories}.id = ? 
      GROUP BY day
      ORDER BY day DESC
      ;
        ''',
      [dateTime.year, dateTime.month, finance, idSubCategory],
    );
    return maps.isNotEmpty
        ? maps.map((e) => HistoryOperation.fromMap(e)).toList()
        : [];
  }

  static Future<List<Operation>> getListAllOperation(
      DateTime dateTime, int finance) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT ${TableDB.operations}.id AS id,
      ${TableDB.categories}.name AS namecategory,
      ${TableDB.subcategories}.name AS namesubcategory,
      note,
      date,
      ROUND(value, 2) as value
      FROM ${TableDB.operations}
      JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ? AND month = ? AND day = ? AND ${TableDB.finance}.id = ? 
      ORDER BY date DESC
      ;
        ''',
      [dateTime.year, dateTime.month, dateTime.day, finance],
    );
    return maps.isNotEmpty
        ? maps.map((e) => Operation.fromMap(e)).toList()
        : [];
  }

  static Future<List<Operation>> getListOperationCategory(
      DateTime dateTime, int finance, int idCategory) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT ${TableDB.operations}.id AS id,
      ${TableDB.categories}.name AS namecategory,
      ${TableDB.subcategories}.name AS namesubcategory,
      note,
      date,
      ROUND(value, 2) as value
      FROM ${TableDB.operations}
      JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ? AND month = ? AND day = ? AND ${TableDB.finance}.id = ? AND ${TableDB.categories}.id = ? 
      ORDER BY date DESC
      ;
        ''',
      [dateTime.year, dateTime.month, dateTime.day, finance, idCategory],
    );
    return maps.isNotEmpty
        ? maps.map((e) => Operation.fromMap(e)).toList()
        : [];
  }

  static Future<List<Operation>> getListOperationSubCategory(
      DateTime dateTime, int finance, int idSubCategory) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT ${TableDB.operations}.id AS id,
      ${TableDB.categories}.name AS namecategory,
      ${TableDB.subcategories}.name AS namesubcategory,
      note,
      date,
      ROUND(value, 2) as value
      FROM ${TableDB.operations}
      JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ? AND month = ? AND day = ? AND ${TableDB.finance}.id = ? AND ${TableDB.subcategories}.id = ? 
      ORDER BY date DESC
      ;
        ''',
      [dateTime.year, dateTime.month, dateTime.day, finance, idSubCategory],
    );
    return maps.isNotEmpty
        ? maps.map((e) => Operation.fromMap(e)).toList()
        : [];
  }

  static Future<List<SumOperation>> getListSumAllOperation(
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

  static Future<List<SumOperation>> getListSumOperationCategory(
      DateTime dateTime, int finance, int idCategory) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT IFNULL( ROUND(SUM(value), 1),0.0) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory  
      WHERE year = ? AND month = ? AND ${TableDB.categories}.idfinance = ? AND ${TableDB.categories}.id = ?
      ;
        ''',
      [dateTime.year, dateTime.month, finance, idCategory],
    );
    return maps.isNotEmpty
        ? maps.map((e) => SumOperation.fromMap(e)).toList()
        : [];
  }

  static Future<List<SumOperation>> getListSumOperationSubCategory(
      DateTime dateTime, int finance, int idSubCategory) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
      SELECT IFNULL( ROUND(SUM(value), 1),0.0) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory  
      WHERE year = ? AND month = ? AND ${TableDB.categories}.idfinance = ? AND ${TableDB.subcategories}.id = ?
      ;
        ''',
      [dateTime.year, dateTime.month, finance, idSubCategory],
    );
    return maps.isNotEmpty
        ? maps.map((e) => SumOperation.fromMap(e)).toList()
        : [];
  }

  //Получение данных для Аналитики
  static Future<List<AnaliticsYear>> getListAnaliticsYear() async {
    final db = await database;
    var maps = await db.rawQuery('''
    SELECT DISTINCT year
    FROM ${TableDB.operations}
    
    ;
    ''');

    return maps.isNotEmpty
        ? maps.map((e) => AnaliticsYear.fromMap(e)).toList()
        : [];
  }

  static Future<List<AnaliticsMonth>> getListAnaliticsMonth(
      int year, int month) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
    WITH  monthtable AS 
                    (SELECT DISTINCT month
                    FROM ${TableDB.operations}
                    WHERE year = $year AND month = $month
                    ),
    
          exptable AS
                    (SELECT IFNULL(ROUND(-SUM(value),2),-0.0) AS expense
                    FROM ${TableDB.operations}
                    JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
                    JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
                    JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
                    WHERE year = $year AND idfinance = 0 AND month = $month
                    
                    ),
          inctable AS
                    (SELECT IFNULL(ROUND(SUM(value),2),0.0) AS income
                    FROM ${TableDB.operations}
                    JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
                    JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
                    JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
                    WHERE year = $year AND idfinance = 1 AND month = $month
                    
                    ),
          tottable AS 
                    (SELECT (expense + income) AS total
                    FROM exptable, inctable
                    )

    SELECT * FROM monthtable, exptable, inctable, tottable
    ;
    ''',
    );

    return maps.isNotEmpty
        ? maps.map((e) => AnaliticsMonth.fromMap(e)).toList()
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

  static Future<int> deleteAllOperation() async {
    final db = await database;
    return await db.rawDelete('''
    DELETE
    FROM ${TableDB.operations} 
    ;
    ''');
  }

  static Future<int> deleteAll() async {
    final db = await database;
    return await db.rawDelete('''
    DELETE
    FROM ${TableDB.categories} 
    ;
    ''');
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

  static Future<int> updateOperation(
      double newValue, String newNote, Operation operation) async {
    final db = await database;
    return await db.rawUpdate('''
    UPDATE ${TableDB.operations}
    SET value = ?, note = ?
    WHERE id = ?;
    ''', [
      newValue,
      newNote,
      operation.id,
    ]);
  }
}
