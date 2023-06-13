import 'package:flutter/material.dart';

class Operation {
  final String date;
  final double value;
  final String comment;
  final String color;

  Operation({
    required this.date,
    required this.value,
    required this.comment,
    required this.color,
  });

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'value': value,
      'comment': comment,
      'color': color,
    };
  }

  //Чтение БД
  factory Operation.fromMap(Map<String, dynamic> json) => Operation(
        date: json['date'],
        value: json['value'],
        comment: json['comment'],
        color: json['color'],
      );

  Color colorCategory() {
    return Color(int.parse(color));
  }
}
