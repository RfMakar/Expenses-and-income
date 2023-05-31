import 'package:flutter/material.dart';

abstract class WidgetDialogApp {
  static Future<String?> dialogSubCategory(
    String? nameSubcategory,
    BuildContext context,
  ) async {
    String? text = await showDialog(
        context: context,
        builder: (context) {
          final textEditingController =
              TextEditingController(text: nameSubcategory);
          return AlertDialog(
            title: const Center(child: Text('Подкатегория')),
            content: TextField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 30,
              controller: textEditingController,
              decoration: const InputDecoration(
                labelText: 'Название',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, textEditingController.text);
                },
                child: Text(nameSubcategory == null ? 'Добавить' : 'Изменить'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, null),
                child: const Text('Отмена'),
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
