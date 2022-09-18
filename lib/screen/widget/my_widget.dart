import 'package:flutter/material.dart';

abstract class MyWidget {
  static Widget widgetLoading() {
    return const Center(child: Text('Загрузка...'));
  }

  static Widget widgetIsEmpty() {
    return Container(
      color: Colors.transparent,
      child: const Center(child: Text('Нет данных')),
    );
  }

  static RoundedRectangleBorder widgetShapeBorderListTile(int colorValue) {
    return RoundedRectangleBorder(
        side: BorderSide(
          color: Color(colorValue),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15));
  }

  static void mySnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
          ],
        ),
      ),
    );
  }
}

//new widget
class MySnackBar extends StatelessWidget {
  const MySnackBar({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
        ],
      ),
    );
  }
}
