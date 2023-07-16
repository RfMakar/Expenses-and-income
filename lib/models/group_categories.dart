//Группа категорий для виджета на главном экране
class GroupCategories {
  final int idcategories;
  final String name;
  final String color;
  final double percent;
  final double value;

  GroupCategories({
    required this.idcategories,
    required this.name,
    required this.color,
    required this.percent,
    required this.value,
  });

  //Чтение БД
  factory GroupCategories.fromMap(Map<String, dynamic> json) => GroupCategories(
        idcategories: json['idcategories'],
        name: json['name'],
        color: json['color'],
        percent: json['percent'],
        value: json['value'],
      );
}
