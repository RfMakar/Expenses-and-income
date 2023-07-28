import 'package:flutter/material.dart';

class DialodgDelete extends StatelessWidget {
  const DialodgDelete({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Удалить?')),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Да'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Нет'),
            ),
          ],
        ),
      ],
    );
  }
}
