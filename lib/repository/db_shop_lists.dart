import 'package:budget/models/app_shop_list/record_list.dart';
import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TableDB {
  static const shopList = 'shoplist';
  static const recordList = 'recordlist';
}

abstract class DBShopList {
  static Database? _database;

  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'shoplists.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${TableDB.shopList}(
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
    );
    ''');
    await db.execute('''
    CREATE TABLE ${TableDB.recordList}(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idshoplist INTEGER REFERENCES ${TableDB.shopList} (id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    isselected INTEGER NOT NULL
    );
    ''');
  }

  //Запись в БД
  static Future<int> insertShopList(WriteShopList writeShopList) async {
    final db = await database;
    return await db.insert(TableDB.shopList, writeShopList.toMap());
  }

  static Future<int> insertRecordList(WriteRecordList writeRecordList) async {
    final db = await database;
    return await db.insert(TableDB.recordList, writeRecordList.toMap());
  }

  //Получить данные
  static Future<List<ShopList>> getListShopList() async {
    final db = await database;
    var maps = await db.rawQuery('''
    SELECT id, name
    FROM ${TableDB.shopList}
    ORDER BY id DESC;
    ''');
    return maps.isNotEmpty ? maps.map((e) => ShopList.fromMap(e)).toList() : [];
  }

  static Future<List<RecordList>> getListRecordList(int idShopList) async {
    final db = await database;
    var maps = await db.rawQuery('''
    SELECT id, name, isselected
    FROM ${TableDB.recordList}
    WHERE idshoplist = $idShopList 
    ORDER BY isselected, id DESC;
    ''');
    return maps.isNotEmpty
        ? maps.map((e) => RecordList.fromMap(e)).toList()
        : [];
  }

  //Обновить данные

  static Future<int> updateShopListName(String newName, int idShopList) async {
    final db = await database;
    return await db.rawUpdate('''
    UPDATE ${TableDB.shopList} 
    SET name = ?
    WHERE id = ?;
    ''', [newName, idShopList]);
  }

  static Future<int> updateRecordListName(
      String newName, int idRecordList) async {
    final db = await database;
    return await db.rawUpdate('''
    UPDATE ${TableDB.recordList} 
    SET name = ?
    WHERE id = ?;
    ''', [newName, idRecordList]);
  }

  static Future<int> updateSelectedRecordList(
      int selected, int idRecordList) async {
    final db = await database;
    return await db.rawUpdate('''
    UPDATE ${TableDB.recordList} 
    SET isselected = ?
    WHERE id = ?;
    ''', [selected, idRecordList]);
  }

  static Future<int> markRecordList(int idShopList) async {
    //Выбрать все RecordList
    final db = await database;
    return await db.rawUpdate('''
    UPDATE ${TableDB.recordList} 
    SET isselected = 1
    WHERE idshoplist = ?;
    ''', [idShopList]);
  }

  static Future<int> restoreRecordList(int idShopList) async {
    //Снять выбраные RecordList
    final db = await database;
    return await db.rawUpdate('''
    UPDATE ${TableDB.recordList} 
    SET isselected = 0
    WHERE idshoplist = ?;
    ''', [idShopList]);
  }

  //Удалить данные

  static Future<int> deleteShopList(int idShopList) async {
    final db = await database;
    return await db.rawDelete('''
    DELETE
      FROM ${TableDB.shopList} 
      WHERE id = ?;
    ''', [idShopList]);
  }

  static Future<int> deleteRecordList(int idRecordList) async {
    final db = await database;
    return await db.rawDelete('''
    DELETE
      FROM ${TableDB.recordList} 
      WHERE id = ?;
    ''', [idRecordList]);
  }

  static Future<int> deleteSelecetRecordList(int idShopList) async {
    //Удаляет выбранные recordlist из shoplist
    final db = await database;
    return await db.rawDelete('''
    DELETE
      FROM ${TableDB.recordList} 
      WHERE isselected = 1 AND idshoplist = ?;
    ''', [idShopList]);
  }

  static Future<int> clearShopList(int idShopList) async {
    //Очистка recordlist в shoplist
    final db = await database;
    return await db.rawDelete('''
    DELETE
      FROM ${TableDB.recordList} 
      WHERE idshoplist = ?;
    ''', [idShopList]);
  }
}
