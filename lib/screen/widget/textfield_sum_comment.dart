import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldSumComment extends StatelessWidget {
  const TextFieldSumComment({
    Key? key,
    required this.textControllerSum,
    required this.textControllerComment,
    required this.validate,
    required this.focusNode,
    required this.focusNodeCom,
  }) : super(key: key);

  final TextEditingController textControllerSum;
  final TextEditingController textControllerComment;
  final bool validate;
  final FocusNode focusNode;
  final FocusNode focusNodeCom;

  static final inputFormatters = [
    //Запрет вводить '..' и ','вместо этого будет '.'
    FilteringTextInputFormatter.deny(
      RegExp(r'[..,,]+'),
      replacementString: '.',
    ),
    //Запрет вводить '-' и ' '
    FilteringTextInputFormatter.deny(
      RegExp(r'[-, ]+'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: TextField(
              controller: textControllerSum,
              keyboardType: TextInputType.number,
              focusNode: focusNode,
              //textInputAction: TextInputAction.next,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: 'Сумма',
                errorText: validate ? 'Введите число' : null,
              ),
              inputFormatters: inputFormatters,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: TextField(
              controller: textControllerComment,
              focusNode: focusNodeCom,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 30,
              decoration: const InputDecoration(hintText: 'Комментарий'),
            ),
          ),
        ),
      ],
    );
  }
}
