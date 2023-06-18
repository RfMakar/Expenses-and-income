import 'package:budget/dialogs/add_account/dialog_add_account.dart';
import 'package:budget/screen2/add_finance/provider_screen_add_finance.dart';
import 'package:budget/screen2/widget/buttons_date_time.dart';
import 'package:budget/screen2/widget/list_accounts.dart';
import 'package:budget/screen2/widget/switch_expence_income.dart';
import 'package:budget/screen2/widget/textfield_value.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenAddFinance extends StatelessWidget {
  const ScreenAddFinance({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenAddFinance(),
      child: Consumer<ProviderScreenAddFinance>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Новая запись'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.check),
            ),
            body: ListView(
              children: [
                WidgetFinance(),
                Divider(),
                WidgetAccount(),
                Divider(),
                WidgetCategories(),
                Divider(),
                WidgetValueNote(),
                Divider(),
                ButtonsDateTime(
                  dateTime: provider.dateTime,
                  timeOfDay: provider.timeOfDay,
                  onChangedDate: provider.onChangedDate,
                  onChangedTime: provider.onChangedTime,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WidgetFinance extends StatelessWidget {
  const WidgetFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenAddFinance>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: SwitchExpensesIncome(
        onPressedCallBack: provider.onPressedSwitchExpInc,
      ),
    );
  }
}

class WidgetAccount extends StatelessWidget {
  const WidgetAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenAddFinance>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Счет'),
            IconButton(
              onPressed: () async {
                final bool update = await showDialog(
                  context: context,
                  builder: (context) => const DialogAddAccount(),
                );

                if (update) {
                  provider.updateScreen();
                }
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const WidgetListAccounts(),
      ],
    );
  }
}

class WidgetCategories extends StatelessWidget {
  const WidgetCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text('Категория / Подкатегория'),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Выбрать'),
        ),
      ],
    );
  }
}

class WidgetValueNote extends StatelessWidget {
  const WidgetValueNote({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenAddFinance>(context);
    return Container(
      margin: const EdgeInsets.all(8),
      // padding: const EdgeInsets.all(8),
      // decoration: const BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.all(Radius.circular(8)),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.blue,
      //       blurRadius: 2,
      //       offset: Offset(1, 1), // Shadow position
      //     ),
      //   ],
      // ),
      child: Column(
        children: [
          Row(
            children: const [
              Text('Сумма'),
            ],
          ),
          TextFieldValue(
              textEditingController: provider.textEditingControllerValue),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text('Заметка'),
            ],
          ),
          const TextField(
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
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
                gapPadding: 0,
              ),
              hintText: '...',
            ),
          ),
        ],
      ),
    );
  }
}
