import 'package:budget/repositories/finance/models/subcategories.dart';

abstract class Categories {
  String name;
  String color;

  Categories({required this.name, required this.color});

  void rename(String name) {
    this.name = name;
  }

  void changeColor(String color) {
    this.color = color;
  }
}

//Column table -> |id|idfinace|name|color|
class WriteCategory extends Categories {
  final int idfinance;

  WriteCategory({
    required this.idfinance,
    required super.name,
    required super.color,
  });

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'idfinance': idfinance,
      'name': name,
      'color': color,
    };
  }
}

//Column table -> |id|name|color|
class ReadCategory extends Categories {
  final int id;

  ReadCategory({required this.id, required super.name, required super.color});
}

//Column table -> |id|name|color| + Column table -> |id|name|
class Category extends ReadCategory {
  List<SubCategory>? listSubCategory;
  Category({
    required super.id,
    required super.name,
    required super.color,
    this.listSubCategory,
  });
  //Чтение БД
  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        color: json['color'],
      );
}

//Column table -> |id|name|color|percent|value|
class GroupCategory extends ReadCategory {
  final double percent;
  final double value;

  GroupCategory({
    required super.id,
    required super.name,
    required super.color,
    required this.percent,
    required this.value,
  });

  //Чтение БД
  factory GroupCategory.fromMap(Map<String, dynamic> json) => GroupCategory(
        id: json['id'],
        name: json['name'],
        color: json['color'],
        percent: json['percent'],
        value: json['value'],
      );
}
