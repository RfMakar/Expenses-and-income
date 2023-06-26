import 'package:budget/model/subcategories.dart';

class Categories {
  int? id;
  int? idoperations;
  final String name;
  final String color;
  List<SubCategories>? listSubcategories;

  Categories({
    this.id,
    this.idoperations,
    required this.name,
    required this.color,
    this.listSubcategories,
  });

  // //Для записи в БД
  // Map<String, dynamic> toMap() {
  //   return {
  //     'idoperations': idoperations,
  //     'name': name,
  //     'color': color,
  //   };
  // }

  //Чтение БД
  factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        id: json['id'],
        name: json['name'],
        color: json['color'],
      );
}
