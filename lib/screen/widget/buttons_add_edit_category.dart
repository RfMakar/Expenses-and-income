import 'package:flutter/material.dart';

class ButtonAddEditCategory extends StatelessWidget {
  final String nameButton;
  final IconData icons;
  final void Function() onPressed;
  const ButtonAddEditCategory(
      {Key? key,
      required this.nameButton,
      required this.icons,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icons),
      label: Text(nameButton),
      onPressed: onPressed,
    );
  }
}
