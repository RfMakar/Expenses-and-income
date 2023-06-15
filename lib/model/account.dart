class Account {
  int? id;
  double? value;
  final String name;
  final String color;

  Account({
    this.id,
    this.value,
    required this.name,
    required this.color,
  });

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
    };
  }

  //Чтение БД
  factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json['id'],
        name: json['name'],
        color: json['color'],
        value: json['value'],
      );
}
