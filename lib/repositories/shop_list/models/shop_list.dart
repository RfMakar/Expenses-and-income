abstract class ShopLists {
  final String name;
  ShopLists({required this.name});
}

//Column table -> |name|
class WriteShopList extends ShopLists {
  WriteShopList({required super.name});

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}

//Column table -> |id|name|
class ReadShopList extends ShopLists {
  final int id;
  ReadShopList({required this.id, required super.name});
}

//Column table -> |id|name|
class ShopList extends ReadShopList {
  ShopList({required super.id, required super.name});
  //Чтение БД
  factory ShopList.fromMap(Map<String, dynamic> json) => ShopList(
        id: json['id'],
        name: json['name'],
      );
}
