import 'package:flutter/material.dart';

class ButtonSelectCategory extends StatelessWidget {
  const ButtonSelectCategory({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  final String name;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [Text('Категория')],
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onPressed,
            child: Text(name),
          ),
        ),
      ],
    );
  }
}
