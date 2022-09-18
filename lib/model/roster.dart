class Roster {
  final String name;

  Roster({required this.name});

  factory Roster.fromMap(Map<String, dynamic> json) => Roster(
        name: json['name'],
      );

  //Для записи в БД
  Map<String, dynamic> toMap() => {
        'name': name,
      };
}
