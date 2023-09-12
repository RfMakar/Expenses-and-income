import 'package:budget/const/color.dart';
import 'package:flutter/material.dart';

class SheetColors extends StatelessWidget {
  const SheetColors({super.key});

  @override
  Widget build(BuildContext context) {
    const listColors = ColorApp.listColor;
    return Wrap(
      children: [
        const SizedBox(
          height: 50,
          child: Center(
              child: Text('Выберите цвет', style: TextStyle(fontSize: 16))),
        ),
        const Divider(),
        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: listColors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: listColors[index],
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(0.5, 0.5), // Shadow position
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.brush,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context, listColors[index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
