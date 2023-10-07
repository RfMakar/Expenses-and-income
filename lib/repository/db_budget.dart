import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  static Future<List<Cat>> getListCat(String nameTable) async {
    final db = await database;
    var maps = await db.rawQuery(
      '''
    SELECT category, color
    FROM $nameTable
    GROUP BY category, color
    ORDER BY category;
    ''',
    );
    return maps.isNotEmpty ? maps.map((e) => Cat.fromMap(e)).toList() : [];
  }

  static Future<List<SubCat>> getListSubCat(
      String nameCategory, String nameTable) async {
    final db = await database;
    var maps = await db.rawQuery('''
    SELECT subcategory
    FROM $nameTable
    WHERE category = ?
    GROUP BY subcategory
    ORDER BY subcategory;
    ''', [nameCategory]);
    return maps.isNotEmpty ? maps.map((e) => SubCat.fromMap(e)).toList() : [];
  }

  static Future<List<Oper>> getListOper(
      String nameCategory, String nameSubCategory, String nameTable) async {
    final db = await database;
    var maps = await db.rawQuery('''
    SELECT sum, comment, year, month, day, hour, minute
    FROM $nameTable
    WHERE category = ? AND subcategory = ?
    ;
    ''', [nameCategory, nameSubCategory]);
    return maps.isNotEmpty ? maps.map((e) => Oper.fromMap(e)).toList() : [];
  }

  static Future<int> deleteTable(String nameTable) async {
    final db = await database;
    return await db.rawDelete('''
    DELETE
    FROM $nameTable
    ;
    ''');
  }
}

class Oper {
  final double sum;
  final String comment;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  Oper({
    required this.sum,
    required this.comment,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
  });
  //Чтение БД
  factory Oper.fromMap(Map<String, dynamic> json) => Oper(
        sum: json['sum'],
        comment: json['comment'],
        year: json['year'],
        month: json['month'],
        day: json['day'],
        hour: json['hour'],
        minute: json['minute'],
      );
}

class Cat {
  final String category;
  final int color;

  Cat({required this.category, required this.color});
  //Чтение БД
  factory Cat.fromMap(Map<String, dynamic> json) => Cat(
        category: json['category'],
        color: json['color'],
      );
}

class SubCat {
  final String subcategory;
  SubCat({required this.subcategory});

  //Чтение БД
  factory SubCat.fromMap(Map<String, dynamic> json) => SubCat(
        subcategory: json['subcategory'],
      );
}
