import 'package:flutter/material.dart';

class SheetHistory extends StatelessWidget {
  const SheetHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
            title: Text(
          'История операций',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
      ],
    );
  }
}
