abstract class Operations {
  final double value;

  Operations({required this.value});
}

//Column table -> |idsubcategory|date|year|month|day|note|value|
class WriteOperation extends Operations {
  final int idSubcategory;
  final String date;
  final int year;
  final int month;
  final int day;
  final String note;
  WriteOperation({
    required this.idSubcategory,
    required this.date,
    required this.year,
    required this.month,
    required this.day,
    required this.note,
    required super.value,
  });
  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'idsubcategory': idSubcategory,
      'date': date,
      'year': year,
      'month': month,
      'day': day,
      'note': note,
      'value': value,
    };
  }
}

//Column table -> |id|date|value|
class ReadOperation extends Operations {
  final int id;
  final String date;
  ReadOperation({required this.id, required this.date, required super.value});
}

//Column table -> |id|namecategory|namesubcategory|date|value|
class HistoryOperation extends ReadOperation {
  final String nameCategory;
  final String nameSubCategory;

  HistoryOperation({
    required super.id,
    required this.nameCategory,
    required this.nameSubCategory,
    required super.date,
    required super.value,
  });

  //Чтение БД
  factory HistoryOperation.fromMap(Map<String, dynamic> json) =>
      HistoryOperation(
        id: json['id'],
        nameCategory: json['namecategory'],
        nameSubCategory: json['namesubcategory'],
        date: json['date'],
        value: json['value'],
      );
}

//Column table -> |value|
class SumOperation extends Operations {
  SumOperation({required super.value});
  //Чтение БД
  factory SumOperation.fromMap(Map<String, dynamic> json) => SumOperation(
        value: json['value'],
      );
}

/*


//Column table -> |id|idfinace|name|color|
class WriteCategory extends Categories {
  final int idfinance;

  WriteCategory({
    required this.idfinance,
    required super.name,
    required super.color,
  });

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'idfinance': idfinance,
      'name': name,
      'color': color,
    };
  }
}

//Column table -> |id|name|color|
class ReadCategory extends Categories {
  final int id;

  ReadCategory({required this.id, required super.name, required super.color});
}

//Column table -> |id|name|color| + Column table -> |id|name|
class Category extends ReadCategory {
  List<SubCategory>? listSubCategories;
  Category({
    required super.id,
    required super.name,
    required super.color,
    this.listSubCategories,
  });
  //Чтение БД
  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        color: json['color'],
      );
}

//Column table -> |id|name|color|percent|value|
class CategoryGroup extends ReadCategory {
  final double percent;
  final double value;

  CategoryGroup({
    required super.id,
    required super.name,
    required super.color,
    required this.percent,
    required this.value,
  });

  //Чтение БД
  factory CategoryGroup.fromMap(Map<String, dynamic> json) => CategoryGroup(
        id: json['id'],
        name: json['name'],
        color: json['color'],
        percent: json['percent'],
        value: json['value'],
      );
}


*/