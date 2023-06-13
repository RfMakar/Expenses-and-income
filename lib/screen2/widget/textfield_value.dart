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
    return SizedBox(
      width: 200,
      child: TextField(
        //autofocus: true,
        controller: textEditingController,
        keyboardType: TextInputType.number,
        inputFormatters: inputFormatters,
        textAlign: TextAlign.center,
        // enableSuggestions: false,
        // //cursorColor: ColorApp.colorIcon,
        // style: const TextStyle(
        //   //color: ColorApp.colorText,
        //   fontSize: 20,
        //   fontWeight: FontWeight.bold,
        // ),
        decoration: const InputDecoration(
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.white,
          //   ),
          // ),
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.white,
          //   ),
          // ),
          // labelStyle: TextStyle(
          //   color: ColorApp.colorText,
          // ),
          // counterStyle: TextStyle(
          //   color: ColorApp.colorText,
          // ),
          hintText: '0',
          suffixIcon: Icon(
            Icons.currency_ruble,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
