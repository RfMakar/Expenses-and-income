import 'package:budget/provider_app.dart';
import 'package:budget/sheets/history/sheet_history.dart';
import 'package:budget/sheets/select_period/sheet_select_period.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetSwitchDate extends StatelessWidget {
  const WidgetSwitchDate({
    super.key,
    required this.titleValue,
    required this.onPressedButBackDate,
    required this.onPressedButNextDate,
  });
  final String titleValue;
  final void Function() onPressedButBackDate;
  final void Function() onPressedButNextDate;
  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    return Card(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            titleValue,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const SheetHistory(),
                  );
                },
                icon: const Icon(Icons.history_outlined),
              ),
              Row(
                children: [
                  IconButton(
                    color: Colors.grey,
                    icon: const Icon(Icons.navigate_before),
                    onPressed: onPressedButBackDate,
                  ),
                  Text(
                    providerApp.switchDate.getDate(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  IconButton(
                    color: Colors.grey,
                    onPressed: onPressedButNextDate,
                    icon: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const SheetSelectPeriod(),
                  );
                },
                icon: const Icon(Icons.date_range_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
