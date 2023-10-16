import 'package:flutter/material.dart';

class WidgetNoData extends StatelessWidget {
  const WidgetNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Нет данных'),
    ));
  }
}
