abstract class SubCategories {
  final String name;

  SubCategories({required this.name});
}

//Column table -> |id|idcategory|name|
class WriteSubCategory extends SubCategories {
  final int idCategory;
  WriteSubCategory({required this.idCategory, required super.name});
  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'idcategory': idCategory,
      'name': name,
    };
  }
}

//Column table -> |id|name|
class ReadSubCategory extends SubCategories {
  final int id;

  ReadSubCategory({required this.id, required super.name});
}

//Column table -> |id|name|
class SubCategory extends ReadSubCategory {
  SubCategory({required super.id, required super.name});
  //Чтение БД
  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        id: json['id'],
        name: json['name'],
      );
}
