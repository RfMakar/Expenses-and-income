import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldValue extends StatelessWidget {
  const TextFieldValue({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

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
          child: TextField(
            //autofocus: true,
            controller: textEditingController,
            keyboardType: TextInputType.number,
            inputFormatters: inputFormatters,
            textAlign: TextAlign.center,
            enableSuggestions: false,
            //cursorColor: ColorApp.colorIcon,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),

            decoration: const InputDecoration(
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(width: 2),
              ),
              //contentPadding: EdgeInsets.symmetric(vertical: 12.0),

              hintText: '0',
            ),
          ),
        ),
        const SizedBox(
          width: 50,
          child: Icon(Icons.currency_ruble),
        ),
      ],
    );
  }
}
