class Finance {
  final String date;
  final String category;
  final String subcategory;
  final double value;
  final String comment;
  final String color;

  Finance({
    required this.date,
    required this.category,
    required this.subcategory,
    required this.value,
    required this.comment,
    required this.color,
  });

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'category': category,
      'subcategory': subcategory,
      'value': value,
      'comment': comment,
      'color': color,
    };
  }

  //Чтение БД
  factory Finance.fromMap(Map<String, dynamic> json) => Finance(
        date: json['date'],
        category: json['category'],
        subcategory: json['subcategory'],
        value: json['value'],
        comment: json['comment'],
        color: json['color'],
      );
}
