class Category {
  final String name;
  final double value;
  final String color;
  final double percent;

  Category({
    required this.name,
    required this.value,
    required this.color,
    required this.percent,
  });

  //Чтение БД
  factory Category.fromMap(Map<String, dynamic> json) => Category(
        name: json['name'],
        value: json['value'],
        color: json['color'],
        percent: json['percent'],
      );

  String percentToString() {
    return '$percent %';
  }
}
