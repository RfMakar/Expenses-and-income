import 'package:budget/model/shop_list.dart';
import 'package:budget/model/roster.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBShopList {
  static const _nameDB = 'shoplist.db';
  static const _nameTable = 'shoplisttable';
  static Database? _database;
  static Future<Database> get database async =>
      _database ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _nameDB);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute(''' CREATE TABLE $_nameTable(
        nameList TEXT, 
        nameProduct TEXT,
        isSelected INTEGER
        );''');
  }

  static Future<int> insert(ShopList shopList) async {
    final db = await database;
    return await db.insert(_nameTable, shopList.toMap());
  }

  static Future<int> update(ShopList newShopList, ShopList editShopList) async {
    final db = await database;
    return await db.rawUpdate(
      '''UPDATE $_nameTable
        SET nameList = ?, nameProduct = ?, isSelected = ?
        WHERE nameList = ? AND nameProduct = ? AND isSelected = ?;
      ''',
      [
        newShopList.nameList,
        newShopList.nameProduct,
        newShopList.isSelected,
        editShopList.nameList,
        editShopList.nameProduct,
        editShopList.isSelected,
      ],
    );
  }

  static Future<int> updateRoster(Roster newRoster, Roster editRoster) async {
    final db = await database;
    return await db.rawUpdate(
        'UPDATE $_nameTable SET nameList = ? WHERE nameList = ?;',
        [newRoster.name, editRoster.name]);
  }

  static Future<int> deleteShopListTable() async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $_nameTable;');
  }

  static Future<int> delete(ShopList shopList) async {
    final db = await database;
    return await db.rawDelete('''DELETE FROM $_nameTable 
          WHERE nameList = ? AND nameProduct = ? AND isSelected = ?;''',
        [shopList.nameList, shopList.nameProduct, shopList.isSelected]);
  }

  static Future<int> deleteSelect(Roster roster) async {
    final db = await database;
    return await db.rawDelete('''DELETE FROM $_nameTable 
          WHERE nameList = ? AND isSelected = 1; ''', [roster.name]);
  }

  static Future<int> deleteRoster(Roster roster) async {
    final db = await database;
    return await db.rawDelete(
        'DELETE FROM $_nameTable WHERE nameList = ?;', [roster.name]);
  }

  static Future<List<ShopList>> getList(Roster roster) async {
    final db = await database;
    var maps = await db.rawQuery(''' SELECT*
          FROM $_nameTable
          WHERE nameList = ?
          ORDER BY isSelected ASC, nameProduct ASC;
      ''', [roster.name]);
    List<ShopList> list =
        maps.isNotEmpty ? maps.map((e) => ShopList.fromMap(e)).toList() : [];
    return list;
  }
}
