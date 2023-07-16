import 'package:budget/models/subcategories.dart';

class Categories {
  int? id;
  int? idfinance;
  final String name;
  final String color;
  List<SubCategories>? listSubcategories;

  Categories({
    this.id,
    this.idfinance,
    required this.name,
    required this.color,
    this.listSubcategories,
  });

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'idfinance': idfinance,
      'name': name,
      'color': color,
    };
  }

  //Чтение БД
  factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        id: json['id'],
        name: json['name'],
        color: json['color'],
      );
}
