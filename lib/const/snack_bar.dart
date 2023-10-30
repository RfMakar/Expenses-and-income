import 'package:flutter/material.dart';

class SnackBarApp {
  static const snackBarAdd = SnackBar(
    backgroundColor: Colors.green,
    content: Center(child: Text('Добавлено')),
  );
  static const snackBarDelete = SnackBar(
    backgroundColor: Colors.red,
    content: Center(child: Text('Удалено')),
  );
  static const snackBarEdit = SnackBar(
    backgroundColor: Colors.green,
    content: Text('Изменено'),
  );
}
