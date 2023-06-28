import 'package:budget/const/const_color.dart';
import 'package:flutter/material.dart';

class WidgetSelectedColor extends StatelessWidget {
  const WidgetSelectedColor({super.key});

  @override
  Widget build(BuildContext context) {
    const listColors = ColorApp.listColor;
    return Stack(
      children: [
        GridView.builder(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 40),
          itemCount: listColors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: listColors[index], shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.brush, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, listColors[index]);
                },
              ),
            );
          },
        ),
        Container(
          height: 35,
          color: Colors.white.withOpacity(0.8),
          child: const Center(child: Text('Выбрать цвет')),
        ),
      ],
    );
  }
}
