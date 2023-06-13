import 'package:flutter/material.dart';

class SwitchExpensesIncome extends StatefulWidget {
  const SwitchExpensesIncome({super.key, required this.onPressedCallBack});

  final void Function(List<bool>) onPressedCallBack;

  @override
  State<SwitchExpensesIncome> createState() => _SwitchExpensesIncomeState();
}

class _SwitchExpensesIncomeState extends State<SwitchExpensesIncome> {
  final List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    final widthToggle = MediaQuery.of(context).size.width * (0.77 / 2.0);

    return Center(
      child: ToggleButtons(
        constraints: BoxConstraints(maxHeight: 30, minWidth: widthToggle),
        isSelected: isSelected,
        onPressed: (index) {
          for (int i = 0; i < isSelected.length; i++) {
            if (index == i) {
              isSelected[i] = true;
            } else {
              isSelected[i] = false;
            }
          }
          setState(() {
            widget.onPressedCallBack(isSelected);
          });
        },
        children: const [
          Center(child: Text('Расход')),
          Center(child: Text('Доход')),
        ],
      ),
    );
  }
}
