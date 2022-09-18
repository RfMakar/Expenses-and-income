import 'package:flutter/material.dart';

class ButtonsAddEditExpenses extends StatelessWidget {
  const ButtonsAddEditExpenses({
    Key? key,
    required this.nameButton,
    required this.icons,
    required this.onPressed,
  }) : super(key: key);
  final String nameButton;
  final IconData icons;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icons),
      label: Text(nameButton),
    );
  }
}
