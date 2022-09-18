import 'package:flutter/material.dart';

//Виджет переключатель |Расход|Доход|
class ButtonsExpensesIncome extends StatelessWidget {
  const ButtonsExpensesIncome({
    Key? key,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);
  final List<bool> isSelected;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    final widthToggle = MediaQuery.of(context).size.width * (0.7 / 2.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButtons(
          constraints: BoxConstraints(minHeight: 30, minWidth: widthToggle),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          isSelected: isSelected,
          onPressed: onPressed,
          children: const [
            Center(child: Text('Расход')),
            Center(child: Text('Доход')),
          ],
        ),
      ],
    );
  }
}
