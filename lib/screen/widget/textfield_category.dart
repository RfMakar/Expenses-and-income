import 'package:flutter/material.dart';

class TextFieldCategory extends StatelessWidget {
  final TextEditingController textController;
  final bool validate;
  const TextFieldCategory({
    Key? key,
    required this.textController,
    required this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 30,
      controller: textController,
      decoration: InputDecoration(
        hintText: 'Введите название',
        errorText: validate ? 'Введите категорию' : null,
      ),
    );
  }
}
