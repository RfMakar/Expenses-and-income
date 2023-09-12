import 'package:flutter/material.dart';

class SnackBarApp {
  static const snackBarAdd = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.green,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    content: Center(child: Text('Добавлено')),
  );
  static const snackBarDelete = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.red,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    content: Center(child: Text('Удалено')),
  );
  static const snackBarEdit = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.green,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    content: Center(child: Text('Изменено')),
  );
}
