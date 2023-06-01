import 'package:flutter/material.dart';

abstract class WidgetDialogApp {
  static Future<String?> dialogSubCategory(
    String? nameSubcategory,
    Color color,
    BuildContext context,
  ) async {
    String? text = await showDialog(
        context: context,
        builder: (context) {
          final exEdContr = TextEditingController(text: nameSubcategory);
          return AlertDialog(
            title: const Center(child: Text('Подкатегория')),
            content: TextField(
              autocorrect: false,
              enableSuggestions: false,
              cursorColor: color,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 30,
              controller: exEdContr,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: color),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: color),
                ),
                labelStyle: TextStyle(color: color),
                counterStyle: TextStyle(color: color),
                labelText: 'Название',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, exEdContr.text);
                },
                child: Text(
                  nameSubcategory == null ? 'Добавить' : 'Изменить',
                  style: TextStyle(
                    color: color,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, null),
                child: Text(
                  'Отмена',
                  style: TextStyle(color: color),
                ),
              ),
            ],
          );
        });
    if (text != null) {
      return text;
    } else {
      return null;
    }
  }
}
