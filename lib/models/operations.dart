import 'package:intl/intl.dart';

abstract class Operations {
  final double value;

  Operations({required this.value});
  String getValue(int finance) {
    return finance == 0
        ? '-${NumberFormat.simpleCurrency(locale: 'ru-RU', decimalDigits: 1).format(value)}'
        : NumberFormat.simpleCurrency(locale: 'ru-RU', decimalDigits: 1)
            .format(value);
  }
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
  final String date;
  ReadOperation({required this.date, required super.value});
}

//Column table -> |date|value| + Column table -> |id|namecategory|namesubcategory|date|value|
class HistoryOperation extends ReadOperation {
  List<Operation>? listOperation;
  HistoryOperation(
      {required super.date, required super.value, this.listOperation});
  //Чтение БД
  factory HistoryOperation.fromMap(Map<String, dynamic> json) =>
      HistoryOperation(
        date: json['date'],
        value: json['value'],
      );
}

//Column table -> |id|namecategory|namesubcategory|note|date|value|
class Operation extends ReadOperation {
  final int id;
  final String nameCategory;
  final String nameSubCategory;
  final String note;
  //Добаваить заметки
  Operation({
    required this.id,
    required this.nameCategory,
    required this.nameSubCategory,
    required this.note,
    required super.date,
    required super.value,
  });

  //Чтение БД
  factory Operation.fromMap(Map<String, dynamic> json) => Operation(
        id: json['id'],
        nameCategory: json['namecategory'],
        nameSubCategory: json['namesubcategory'],
        note: json['note'],
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
//Column table -> |id|namecategory|namesubcategory|date|value|
class Operation extends ReadOperation {
  final int id;
  final String nameCategory;
  final String nameSubCategory;

  Operation({
    required this.id,
    required this.nameCategory,
    required this.nameSubCategory,
    required super.date,
    required super.value,
  });

  //Чтение БД
  factory Operation.fromMap(Map<String, dynamic> json) => Operation(
        id: json['id'],
        nameCategory: json['namecategory'],
        nameSubCategory: json['namesubcategory'],
        date: json['date'],
        value: json['value'],
      );
}

*/