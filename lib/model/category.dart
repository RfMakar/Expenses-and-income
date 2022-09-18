class Category {
  final String name;
  String? subname;
  final int color;

  Category({
    required this.name,
    required this.color,
  });

  Category.sub({
    required this.name,
    required this.subname,
    required this.color,
  });

  factory Category.clonesub(Category category) => Category.sub(
      name: category.name, subname: category.subname, color: category.color);

  factory Category.fromMapCategory(Map<String, dynamic> json) =>
      Category(name: json['name'], color: json['color']);

  //Для записи в БД
  Map<String, dynamic> toMapCategory() {
    return {'name': name, 'color': color};
  }

  factory Category.fromMapSubCategory(Map<String, dynamic> json) =>
      Category.sub(
          name: json['name'], subname: json['subname'], color: json['color']);

  //Для записи в БД
  Map<String, dynamic> toMapSubCategory() {
    return {'name': name, 'subname': subname, 'color': color};
  }
}
