import 'package:budget/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetSwitchFinance extends StatelessWidget {
  const WidgetSwitchFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    final widthToggle = MediaQuery.of(context).size.width * (0.8 / 2.0);
    return Center(
      child: ToggleButtons(
        constraints: BoxConstraints(maxHeight: 30, minWidth: widthToggle),
        isSelected: providerApp.finance.isSelected,
        onPressed: (index) => providerApp.onPressedButFinance(index),
        children: [
          Center(child: Text(providerApp.finance.expense)),
          Center(child: Text(providerApp.finance.income)),
        ],
      ),
    );
  }
}
