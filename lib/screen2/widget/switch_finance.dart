import 'package:flutter/material.dart';

/*
Виджет переключает кнопки расход и доход и возращает число,
где 0 это расход, 1 это доход.
*/

class WidgetSwitchFinance extends StatefulWidget {
  const WidgetSwitchFinance({super.key, required this.onPressedCallBack});

  final void Function(int) onPressedCallBack;

  @override
  State<WidgetSwitchFinance> createState() => _WidgetSwitchFinanceState();
}

class _WidgetSwitchFinanceState extends State<WidgetSwitchFinance> {
  final List<bool> isSelected = [true, false];

  int finance() => isSelected[0] == true ? 0 : 1;

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
            widget.onPressedCallBack(finance());
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
