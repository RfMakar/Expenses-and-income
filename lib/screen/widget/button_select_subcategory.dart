import 'package:flutter/material.dart';

class ButtonSelectSubcategory extends StatelessWidget {
  const ButtonSelectSubcategory({
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
          children: const [Text('Подкатегория')],
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
