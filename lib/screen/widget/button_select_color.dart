import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ButtonSelectColor extends StatelessWidget {
  final Color colorIcon;
  final void Function(Color color) onPressed;
  const ButtonSelectColor(
      {Key? key, required this.colorIcon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      label: const Text('Выбрать цвет'),
      icon: Icon(Icons.color_lens, color: colorIcon),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: SingleChildScrollView(
              child: BlockPicker(
                pickerColor: colorIcon,
                onColorChanged: onPressed,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Выбрать'))
            ],
          ),
        );
      },
    );
  }
}


/*
import 'package:flutter/material.dart';

class ButtonSelectColor extends StatelessWidget {
  final Color colorIcon;
  final void Function() onPressed;
  const ButtonSelectColor(
      {Key? key, required this.colorIcon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      label: const Text('Выбрать цвет'),
      icon: Icon(Icons.color_lens, color: colorIcon),
      onPressed: onPressed,
    );
  }
}

*/
