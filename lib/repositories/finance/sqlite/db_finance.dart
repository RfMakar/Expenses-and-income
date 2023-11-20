import 'package:budget/repositories/finance/models/analitics.dart';
import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/repositories/finance/models/switch_date.dart';
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
      onConfigure: _onConfigure,
    );
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
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
    await db.execute('''
    CREATE TABLE ${TableDB.subcategories}(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idcategory INTEGER REFERENCES ${TableDB.categories} (id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL
    );
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

  static Future<List<GroupCategory>> getListGroupCategoryInPeriod(
    SwitchDate switchDate,
    int finance,
  ) async {
    final db = await database;
    late List<Map<String, Object?>> maps;
    if (switchDate.state == 0) {
      maps = await db.rawQuery('''
      SELECT ${TableDB.categories}.id AS id,
      ${TableDB.categories}.name AS name,
      ${TableDB.categories}.color AS color,
      ROUND(
        SUM(value)/(
          SELECT SUM(value) 
          FROM ${TableDB.operations} 
          JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
          JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory 
          WHERE year = ${switchDate.getDateTime().year} AND month = ${switchDate.getDateTime().month} AND ${TableDB.categories}.idfinance = $finance
        )*100.0, 1 ) as percent,
      ROUND(SUM(value), 2) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      WHERE year = ${switchDate.getDateTime().year} AND month = ${switchDate.getDateTime().month} AND ${TableDB.categories}.idfinance = $finance
      GROUP BY ${TableDB.categories}.id
      ORDER BY value DESC
      ;
        ''');
    } else if (switchDate.state == 1) {
      maps = await db.rawQuery('''
      SELECT ${TableDB.categories}.id AS id,
      ${TableDB.categories}.name AS name,
      ${TableDB.categories}.color AS color,
      ROUND(
        SUM(value)/(
          SELECT SUM(value) 
          FROM ${TableDB.operations} 
          JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
          JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory 
          WHERE year = ${switchDate.getDateTime().year} AND ${TableDB.categories}.idfinance = $finance
        )*100.0, 1 ) as percent,
      ROUND(SUM(value), 2) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      WHERE year = ${switchDate.getDateTime().year}  AND ${TableDB.categories}.idfinance = $finance
      GROUP BY ${TableDB.categories}.id
      ORDER BY value DESC
      ;
        ''');
    }

    return maps.isNotEmpty
        ? maps.map((e) => GroupCategory.fromMap(e)).toList()
        : [];
  }

  static Future<List<GroupSubCategory>> getListGroupSubCategoryInPeriod(
      SwitchDate switchDate, int finance, int idCategory) async {
    final db = await database;
    late List<Map<String, Object?>> maps;
    if (switchDate.state == 0) {
      maps = await db.rawQuery('''SELECT ${TableDB.subcategories}.id AS id,
      ${TableDB.subcategories}.name AS name,
      ROUND(
        SUM(value)/(
          SELECT SUM(value) 
          FROM ${TableDB.operations} 
          JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
          JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory 
          WHERE year = ${switchDate.getDateTime().year} 
            AND month = ${switchDate.getDateTime().month} 
            AND ${TableDB.categories}.idfinance = $finance 
            AND ${TableDB.subcategories}.idcategory = $idCategory
        )*100.0, 1 ) as percent,
      ROUND(SUM(value), 2) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      WHERE year = ${switchDate.getDateTime().year} 
        AND month = ${switchDate.getDateTime().month} 
        AND ${TableDB.categories}.idfinance = $finance
        AND ${TableDB.subcategories}.idcategory = $idCategory
      GROUP BY ${TableDB.subcategories}.id
      ORDER BY value DESC
      ;
        ''');
    } else if (switchDate.state == 1) {
      maps = await db.rawQuery('''SELECT ${TableDB.subcategories}.id AS id,
      ${TableDB.subcategories}.name AS name,
      ROUND(
        SUM(value)/(
          SELECT SUM(value) 
          FROM ${TableDB.operations} 
          JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
          JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory 
          WHERE year = ${switchDate.getDateTime().year} 
            AND ${TableDB.categories}.idfinance = $finance 
            AND ${TableDB.subcategories}.idcategory = $idCategory
        )*100.0, 1 ) as percent,
      ROUND(SUM(value), 1) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      WHERE year = ${switchDate.getDateTime().year} 
        AND ${TableDB.categories}.idfinance = $finance
        AND ${TableDB.subcategories}.idcategory = $idCategory
      GROUP BY ${TableDB.subcategories}.id
      ORDER BY value DESC
      ;
        ''');
    }

    return maps.isNotEmpty
        ? maps.map((e) => GroupSubCategory.fromMap(e)).toList()
        : [];
  }

  //Возращает лист HistoryOperation определенной категории
  static Future<List<HistoryOperation>> getListHistoryOperationCategory(
    SwitchDate switchDate,
    DateTime dateTime,
    int finance,
    int idCategory,
  ) async {
    final db = await database;
    late List<Map<String, Object?>> maps;
    if (switchDate.state == 0) {
      maps = await db.rawQuery('''
      SELECT date,
      ROUND(SUM(value),2) AS value
      FROM ${TableDB.operations}
        JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
        JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
        JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ${dateTime.year} 
        AND month = ${dateTime.month} 
        AND ${TableDB.finance}.id = $finance 
        AND ${TableDB.categories}.id = $idCategory 
      GROUP BY day
      ORDER BY day DESC
      ;
        ''');
    } else if (switchDate.state == 1) {
      maps = await db.rawQuery('''
      SELECT date,
      ROUND(SUM(value),2) AS value
      FROM ${TableDB.operations}
        JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
        JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
        JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ${dateTime.year} 
        AND ${TableDB.finance}.id = $finance 
        AND ${TableDB.categories}.id = $idCategory 
      GROUP BY day, month
      ORDER BY month DESC,day DESC
      ;
        ''');
    }

    return maps.isNotEmpty
        ? maps.map((e) => HistoryOperation.fromMap(e)).toList()
        : [];
  }

  //Возращает лист HistoryOperation определенной подкатегории
  static Future<List<HistoryOperation>> getListHistoryOperationSubCategory(
    SwitchDate switchDate,
    DateTime dateTime,
    int finance,
    int idSubCategory,
  ) async {
    final db = await database;
    late List<Map<String, Object?>> maps;

    if (switchDate.state == 0) {
      maps = await db.rawQuery('''
      SELECT date,
      ROUND(SUM(value),2) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ${dateTime.year} 
        AND month = ${dateTime.month} 
        AND ${TableDB.finance}.id = $finance 
        AND ${TableDB.subcategories}.id = $idSubCategory 
      GROUP BY day
      ORDER BY day DESC
      ;
        ''');
    } else if (switchDate.state == 1) {
      maps = await db.rawQuery('''
      SELECT date,
      ROUND(SUM(value),2) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      WHERE year = ${dateTime.year} 
        AND ${TableDB.finance}.id = $finance 
        AND ${TableDB.subcategories}.id = $idSubCategory 
      GROUP BY day, month
      ORDER BY month DESC,day DESC
      ;
        ''');
    }

    return maps.isNotEmpty
        ? maps.map((e) => HistoryOperation.fromMap(e)).toList()
        : [];
  }

  //Возращает лист операций определенной категории и даты
  static Future<List<Operation>> getListOperationCategory(
      DateTime dateTime, int finance, int idCategory) async {
    final db = await database;
    var maps = await db.rawQuery('''
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
      WHERE year = ${dateTime.year} 
        AND month = ${dateTime.month} 
        AND day = ${dateTime.day} 
        AND ${TableDB.finance}.id = $finance
        AND ${TableDB.categories}.id = $idCategory 
      ORDER BY date DESC
      ;
        ''');
    return maps.isNotEmpty
        ? maps.map((e) => Operation.fromMap(e)).toList()
        : [];
  }

  //Возращает лист операций определенной подкатегории и даты
  static Future<List<Operation>> getListOperationSubCategory(
      DateTime dateTime, int finance, int idSubCategory) async {
    final db = await database;
    var maps = await db.rawQuery('''
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
      WHERE year = ${dateTime.year} 
        AND month = ${dateTime.month} 
        AND day = ${dateTime.day}  
        AND ${TableDB.finance}.id = $finance 
        AND ${TableDB.subcategories}.id = $idSubCategory 
      ORDER BY date DESC
      ;
        ''');
    return maps.isNotEmpty
        ? maps.map((e) => Operation.fromMap(e)).toList()
        : [];
  }

  static Future<SumOperation> getSumAllOperationInPeriod(
      SwitchDate switchDate, int finance) async {
    final db = await database;
    late List<Map<String, Object?>> maps;
    if (switchDate.state == 0) {
      maps = await db.rawQuery('''
      SELECT IFNULL( ROUND(SUM(value), 2),0.0) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory  
      WHERE year = ${switchDate.getDateTime().year} 
        AND month = ${switchDate.getDateTime().month} 
        AND ${TableDB.categories}.idfinance = $finance
      ;
        ''');
    } else if (switchDate.state == 1) {
      maps = await db.rawQuery('''
      SELECT IFNULL( ROUND(SUM(value), 2),0.0) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory  
      WHERE year = ${switchDate.getDateTime().year} 
        AND ${TableDB.categories}.idfinance = $finance
      ;
        ''');
    }
    List<SumOperation> listSumOperation = maps.isNotEmpty
        ? maps.map((e) => SumOperation.fromMap(e)).toList()
        : [];
    return listSumOperation[0];
  }

  static Future<SumOperation> getSumOperationCategoryInPeriod(
      SwitchDate switchDate, int finance, int idCategory) async {
    final db = await database;
    late List<Map<String, Object?>> maps;
    if (switchDate.state == 0) {
      maps = await db.rawQuery('''
      SELECT IFNULL( ROUND(SUM(value), 2),0.0) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory  
      WHERE year = ${switchDate.getDateTime().year}  
        AND month = ${switchDate.getDateTime().month}  
        AND ${TableDB.categories}.idfinance = $finance 
        AND ${TableDB.categories}.id = $idCategory
      ;
        ''');
    } else if (switchDate.state == 1) {
      maps = await db.rawQuery('''
      SELECT IFNULL( ROUND(SUM(value), 2),0.0) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory  
      WHERE year = ${switchDate.getDateTime().year}  
        AND ${TableDB.categories}.idfinance = $finance 
        AND ${TableDB.categories}.id = $idCategory
      ;
        ''');
    }

    List<SumOperation> listSumOperationCategory = maps.isNotEmpty
        ? maps.map((e) => SumOperation.fromMap(e)).toList()
        : [];
    return listSumOperationCategory[0];
  }

  static Future<SumOperation> getSumOperationSubCategoryInPeriod(
      SwitchDate switchDate, int finance, int idSubCategory) async {
    final db = await database;
    late List<Map<String, Object?>> maps;
    if (switchDate.state == 0) {
      maps =
          await db.rawQuery('''SELECT IFNULL( ROUND(SUM(value), 2),0.0) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory  
      WHERE year = ${switchDate.getDateTime().year} 
        AND month = ${switchDate.getDateTime().month}
        AND ${TableDB.categories}.idfinance = $finance
        AND ${TableDB.subcategories}.id = $idSubCategory
      ;
        ''');
    } else if (switchDate.state == 1) {
      maps =
          await db.rawQuery('''SELECT IFNULL( ROUND(SUM(value), 2),0.0) AS value
      FROM ${TableDB.operations}
      JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
      JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory  
      WHERE year = ${switchDate.getDateTime().year} 
        AND ${TableDB.categories}.idfinance = $finance
        AND ${TableDB.subcategories}.id = $idSubCategory
      ;
        ''');
    }

    List<SumOperation> listSumOperationSubCategory = maps.isNotEmpty
        ? maps.map((e) => SumOperation.fromMap(e)).toList()
        : [];
    return listSumOperationSubCategory[0];
  }

  //Получение данных для Аналитики
  static Future<List<AnaliticsByMonth>> getListAnaliticsByMonth(
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
                    (SELECT IFNULL(ROUND(-SUM(value)),-0.0) AS expense
                    FROM ${TableDB.operations}
                    JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
                    JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
                    JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
                    WHERE year = $year AND idfinance = 0 AND month = $month
                    
                    ),
          inctable AS
                    (SELECT IFNULL(ROUND(SUM(value)),0.0) AS income
                    FROM ${TableDB.operations}
                    JOIN ${TableDB.finance} ON ${TableDB.finance}.id = ${TableDB.categories}.idfinance
                    JOIN ${TableDB.categories} ON ${TableDB.categories}.id = ${TableDB.subcategories}.idcategory
                    JOIN ${TableDB.subcategories} ON ${TableDB.subcategories}.id = ${TableDB.operations}.idsubcategory
                    WHERE year = $year AND idfinance = 1 AND month = $month
                    
                    ),
          tottable AS 
                    (SELECT ROUND((expense + income)) AS total
                    FROM exptable, inctable
                    )

    SELECT * FROM monthtable, exptable, inctable, tottable
    ;
    ''',
    );

    return maps.isNotEmpty
        ? maps.map((e) => AnaliticsByMonth.fromMap(e)).toList()
        : [
            AnaliticsByMonth(
                month: month, expense: -0.0, income: 0.0, total: 0.0)
          ];
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

  static Future<int> deleteTableCategory() async {
    final db = await database;
    return await db.rawDelete('''
    DELETE
    FROM ${TableDB.categories} 
    ;
    ''');
  }

  //Обновить данные

  static Future<int> updateCategoryName(String newName, int id) async {
    final db = await database;
    return await db.rawUpdate('''
    UPDATE ${TableDB.categories} 
    SET name = ?
    WHERE id = ?;
    ''', [newName, id]);
  }

  static Future<int> updateCategoryColor(String color, int id) async {
    final db = await database;
    return await db.rawUpdate(
      '''
    UPDATE ${TableDB.categories} 
    SET color = ?
    WHERE id = ?;
    ''',
      [color, id],
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

  static Future<int> updateOperation(DateTime newDate, double newValue,
      String newNote, Operation operation) async {
    final db = await database;
    return await db.rawUpdate(
      '''
    UPDATE ${TableDB.operations}
    SET date = ?, 
        year = ?,
        month = ?,
        day = ?,
        value = ?,
        note = ?
    WHERE id = ?;
    ''',
      [
        newDate.toString(),
        newDate.year,
        newDate.month,
        newDate.day,
        newValue,
        newNote,
        operation.id,
      ],
    );
  }
}

/*
static Future<int> updateOperation(DateTime newDate,
      double newValue, String newNote, Operation operation,) async {
    final db = await database;
    return await db.rawUpdate('''
    UPDATE ${TableDB.operations}
    SET date = ?, value = ?, note = ?, 
    WHERE id = ?;
    ''', [
      newValue,
      newNote,
      operation.id,
    ]);
  }
*/
