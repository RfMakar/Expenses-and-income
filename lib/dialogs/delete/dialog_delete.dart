import 'package:flutter/material.dart';

class DialodgDelete extends StatelessWidget {
  const DialodgDelete({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить?'),
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Да'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Нет'),
        ),
      ],
    );
  }
}
