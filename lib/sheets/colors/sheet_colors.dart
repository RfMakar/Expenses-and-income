import 'package:budget/const/color.dart';
import 'package:flutter/material.dart';

class SheetColors extends StatelessWidget {
  const SheetColors({super.key});

  @override
  Widget build(BuildContext context) {
    const listColors = ColorApp.listColor;
    return Wrap(
      children: [
        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
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
      ],
    );
  }
}
