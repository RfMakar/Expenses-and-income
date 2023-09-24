import 'package:flutter/material.dart';

class DialogDataStorage extends StatelessWidget {
  const DialogDataStorage({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text('Хранение данных'),
      ),
      content: const Text(
          'Все данные (расходы, доходы, операции) хранятся в телефоне локально, при удаление приложения они автоматически удалятся. При обновление приложения данные сохраняются'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Закрыть'),
        ),
      ],
    );
  }
}
