import 'package:budget/screen2/add_finance/provider_screen_add_finance.dart';
import 'package:budget/screen2/widget/buttons_date_time.dart';
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
            body: ListView(
              children: const [
                WidgetFinance(),
                WidgetAccountCategories(),
                WidgetDateTimeValue(),
                WidgetNote(),
                ButtonAddFinance(),
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
    return SwitchExpensesIncome(
      onPressedCallBack: provider.onPressedSwitchExpInc,
    );
  }
}

class WidgetAccountCategories extends StatelessWidget {
  const WidgetAccountCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 2,
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Счет'),
          TextButton(onPressed: () {}, child: Text('Выбрать')),
          const Text('Категория / Подкатегория'),
          TextButton(onPressed: () {}, child: Text('Выбрать')),
        ],
      ),
    );
  }
}

class WidgetDateTimeValue extends StatelessWidget {
  const WidgetDateTimeValue({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenAddFinance>(context);
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 2,
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),
      height: 160,
      child: Column(
        children: [
          ButtonsDateTime(
            dateTime: provider.dateTime,
            timeOfDay: provider.timeOfDay,
            onChangedDate: provider.onChangedDate,
            onChangedTime: provider.onChangedTime,
          ),
          const SizedBox(height: 20),
          TextFieldValue(
              textEditingController: provider.textEditingControllerValue),
        ],
      ),
    );
  }
}

class WidgetNote extends StatelessWidget {
  const WidgetNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 80,
          width: 200,
          child: TextField(
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            textAlign: TextAlign.center,
            maxLength: 30,
            decoration: InputDecoration(
                hintText: 'Заметка',
                suffixIcon: Icon(
                  Icons.sms,
                  color: Colors.blue,
                )),
          ),
        ),
      ],
    );
  }
}

class ButtonAddFinance extends StatelessWidget {
  const ButtonAddFinance({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(onPressed: () {}, child: Text('Сохранить')));
  }
}
