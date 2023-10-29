import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TableDB {
  static const shopList = 'shoplist';
  static const record = 'record';
}

abstract class DBShopList {
  static Database? _database;

  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'shoplist.db');
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
    CREATE TABLE ${TableDB.record}(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idlist INTEGER REFERENCES ${TableDB.shopList} (id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL
    );
    ''');
  }

  //Запись в БД
  static Future<int> insertCategory(WriteShopList writeShopList) async {
    final db = await database;
    return await db.insert(TableDB.shopList, writeShopList.toMap());
  }

  //Получить данные
  static Future<List<ShopList>> getListShopList() async {
    final db = await database;
    var maps = await db.rawQuery('''
    SELECT id, name
    FROM ${TableDB.shopList}
    ORDER BY name;
    ''');
    return maps.isNotEmpty ? maps.map((e) => ShopList.fromMap(e)).toList() : [];
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

  //Удалить данные

  static Future<int> deleteShopList(int idShopList) async {
    final db = await database;
    return await db.rawDelete('''
    DELETE
      FROM ${TableDB.shopList} 
      WHERE id = ?;
    ''', [idShopList]);
  }
}
