class SubCategories {
  int? id;
  int? idcategories;
  final String name;

  SubCategories({
    this.id,
    this.idcategories,
    required this.name,
  });
  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'idcategories': idcategories,
      'name': name,
    };
  }

  //Чтение БД
  factory SubCategories.fromMap(Map<String, dynamic> json) => SubCategories(
        id: json['id'],
        name: json['name'],
      );
}
