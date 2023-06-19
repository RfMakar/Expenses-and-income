class Account {
  int? id;
  double? value;
  final String name;
  final String color;
  final int selection;

  Account({
    this.id,
    this.value,
    required this.name,
    required this.color,
    required this.selection,
  });

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
      'selection': selection,
    };
  }

  //Чтение БД
  factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json['id'],
        value: json['value'],
        name: json['name'],
        color: json['color'],
        selection: json['selection'],
      );
}
