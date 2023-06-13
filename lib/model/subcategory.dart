import 'package:flutter/material.dart';

class SubCategory {
  final String name;
  final double value;
  final String color;
  final double percent;
  final String comment;

  SubCategory({
    required this.name,
    required this.value,
    required this.color,
    required this.percent,
    required this.comment,
  });

  //Чтение БД
  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        name: json['name'],
        value: json['value'],
        color: json['color'],
        percent: json['percent'],
        comment: json['comment'],
      );

  String percentToString() {
    return '$percent %';
  }

  Color colorCategory() {
    return Color(int.parse(color));
  }
}
