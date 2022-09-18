import 'package:budget/model/category.dart';
import 'package:budget/model/budget.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBBudget {
  static Database? _database;

  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'budget.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE exptab(
          category TEXT,
          subcategory TEXT,
          color INTEGER,
          comment TEXT,
          sum REAL,
          year INTEGER,
          month INTEGER,
          day INTEGER,
          hour INTEGER,
          minute INTEGER,
          number INTEGER PRIMARY KEY AUTOINCREMENT
          );
      ''');
    await db.execute('''
      CREATE TABLE inctab(
          category TEXT,
          subcategory TEXT,
          color INTEGER,
          comment TEXT,
          sum REAL,
          year INTEGER,
          month INTEGER,
          day INTEGER,
          hour INTEGER,
          minute INTEGER,
          number INTEGER PRIMARY KEY AUTOINCREMENT
          );
      ''');
  }

  static Future<int> insert(String table, Budget budget) async {
    final db = await database;
    return await db.insert(table, budget.toMap());
  }

  static Future<int> deleteTable(String table) async {
    Database db = await database;
    return await db.rawDelete('DELETE FROM $table;');
  }

  static Future<int> delete(String table, Budget budget) async {
    Database db = await database;
    return await db.rawDelete(
      '''
          DELETE FROM $table 
          WHERE category = ?
          AND subcategory =?
          AND color =?
          AND comment = ?
          AND sum = ?
          AND year = ?
          AND month = ?
          AND day = ?
          AND hour = ?
          AND minute = ?
          AND number = ?
      ''',
      [
        budget.category,
        budget.subcategory,
        budget.color,
        budget.comment,
        budget.sum,
        budget.year,
        budget.month,
        budget.day,
        budget.hour,
        budget.minute,
        budget.number,
      ],
    );
  }

  static Future<int> deleteCategory(String table, Category category) async {
    Database db = await database;
    return await db.rawDelete(
      'DELETE FROM $table WHERE category = ? AND color =?',
      [category.name, category.color],
    );
  }

  static Future<int> deleteSubCategory(String table, Category category) async {
    Database db = await database;
    return await db.rawDelete(
      'DELETE FROM $table WHERE category = ? AND subcategory =? AND color =?',
      [category.name, category.subname, category.color],
    );
  }

  static Future<int> update(
      String table, Budget newBudget, Budget budget) async {
    Database db = await database;
    return await db.rawUpdate(
      '''
        UPDATE $table
        SET category = ?,
            subcategory = ?,
            color = ?,
            comment = ?,
            sum = ?,
            year = ?,
            month = ?,
            day = ?,
            hour = ?,
            minute = ?,
            number = ?
        
        WHERE category = ?
          AND subcategory = ?
          AND color = ?
          AND comment = ?
          AND sum = ?
          AND year = ?
          AND month = ?
          AND day = ?
          AND hour = ?
          AND minute = ?
          AND number = ?;
        ''',
      [
        newBudget.category,
        newBudget.subcategory,
        newBudget.color,
        newBudget.comment,
        newBudget.sum,
        newBudget.year,
        newBudget.month,
        newBudget.day,
        newBudget.hour,
        newBudget.minute,
        newBudget.number,
        budget.category,
        budget.subcategory,
        budget.color,
        budget.comment,
        budget.sum,
        budget.year,
        budget.month,
        budget.day,
        budget.hour,
        budget.minute,
        budget.number,
      ],
    );
  }

  static Future<int> updateCategory(
      String table, Category categoryNew, Category category) async {
    Database db = await database;
    return await db.rawUpdate(
      'UPDATE $table SET category = ?, color = ? WHERE category = ? AND color = ?;',
      [categoryNew.name, categoryNew.color, category.name, category.color],
    );
  }

  static Future<int> updateSubCategory(
      String table, Category categoryNew, Category category) async {
    Database db = await database;
    return await db.rawUpdate(
      '''
        UPDATE $table
        SET category = ?, subcategory = ?, color = ?
        WHERE category = ? AND subcategory = ? AND color = ?;
        ''',
      [
        categoryNew.name,
        categoryNew.subname,
        categoryNew.color,
        category.name,
        category.subname,
        category.color,
      ],
    );
  }

  /*
Возращает список расхода, в новой таблице в зависимости от года и месяца
[категория][цвет][кол-во категорий][сумма расходов]
ScreenHome widget -> GroupListWidget
*/
  static Future<List<Budget>> getListGroup(
      String table, DateTime dateTime, List<bool> isSelected) async {
    final Database db = await database;
    late List<Map<String, Object?>> maps;

    if (isSelected[0]) {
      maps = await db.rawQuery(
        '''SELECT category, color, SUM(sum) AS sum, COUNT(category) AS number
          FROM $table
          WHERE year = ? AND month =? AND day =? 
          GROUP BY category, color
          ORDER BY sum DESC; ''',
        ['${dateTime.year}', '${dateTime.month}', '${dateTime.day}'],
      );
    } else if (isSelected[1]) {
      maps = await db.rawQuery(
        '''SELECT category, color, SUM(sum) AS sum, COUNT(category) AS number
          FROM $table
          WHERE year = ? AND month =? 
          GROUP BY category, color
          ORDER BY sum DESC; ''',
        ['${dateTime.year}', '${dateTime.month}'],
      );
    } else if (isSelected[2]) {
      maps = await db.rawQuery(
        '''SELECT category, color, SUM(sum) AS sum, COUNT(category) AS number
          FROM $table
          WHERE year = ?
          GROUP BY category, color
          ORDER BY sum DESC; ''',
        ['${dateTime.year}'],
      );
    }

    List<Budget> budgetList = maps.isNotEmpty
        ? maps.map((e) => Budget.fromMapCategory(e)).toList()
        : [];

    return budgetList;
  }

  /*
  Возвращает сумму за определеннвую дату(день, месяц, год)
  Для страницы Home widget -> InfoWidget
  */

  static Future<String> getSumToDate(
      String table, DateTime dateTime, List<bool> isSelected) async {
    final Database db = await database;
    var sum = 0.0;
    late String text;
    late List<Map<String, Object?>> maps;

    if (isSelected[0]) {
      maps = await db.rawQuery(
        '''SELECT*
          FROM $table
          WHERE year = ? AND month = ? AND day = ?;''',
        ['${dateTime.year}', '${dateTime.month}', '${dateTime.day}'],
      );
    } else if (isSelected[1]) {
      maps = await db.rawQuery(
        '''SELECT*
          FROM $table
          WHERE year = ? AND month =?; ''',
        ['${dateTime.year}', '${dateTime.month}'],
      );
    } else if (isSelected[2]) {
      maps = await db.rawQuery(
        '''SELECT*
          FROM $table
          WHERE year = ?; ''',
        ['${dateTime.year}'],
      );
    }

    final List<Budget> listBudget =
        maps.isNotEmpty ? maps.map((e) => Budget.fromMap(e)).toList() : [];

    listBudget.map((e) {
      e.sum == null ? (sum += 0) : (sum += e.sum!);
    }).toList();

    text = NumberFormat.currency(locale: 'ru', symbol: '₽').format(sum);

    return text;
  }

  /*
  Возращает лист расходов для за опреленный год месяц и категорию
  Возврат всей таблицы, за определенный год и месяц и категория + сортировка
  Для ScreenHistory
  */
  static Future<List<Budget>> getListHistoryToDate(String table,
      DateTime dateTime, List<bool> isSelected, String nameCategory) async {
    final Database db = await database;
    late List<Map<String, Object?>> maps;

    if (isSelected[0]) {
      maps = await db.rawQuery(
        '''SELECT * 
          FROM $table
          WHERE year = ? AND month = ? AND day = ? AND category = ?
          ORDER BY day DESC, hour DESC, minute DESC; ''',
        [
          '${dateTime.year}',
          '${dateTime.month}',
          '${dateTime.day}',
          nameCategory
        ],
      );
    } else if (isSelected[1]) {
      maps = await db.rawQuery(
        '''SELECT * 
          FROM $table
          WHERE year = ? AND month = ? AND category = ?
          ORDER BY day DESC, hour DESC, minute DESC; ''',
        ['${dateTime.year}', '${dateTime.month}', nameCategory],
      );
    } else if (isSelected[2]) {
      maps = await db.rawQuery(
        '''SELECT * 
          FROM $table
          WHERE year = ? AND category = ?
          ORDER BY day DESC, hour DESC, minute DESC; ''',
        ['${dateTime.year}', nameCategory],
      );
    }
    final List<Budget> budgetList =
        maps.isNotEmpty ? maps.map((e) => Budget.fromMap(e)).toList() : [];
    return budgetList;
  }
}
