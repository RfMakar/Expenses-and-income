import 'package:budget/models/categories.dart';
import 'package:budget/provider_app.dart';
import 'package:budget/screen/category/provider_screen_category.dart';
import 'package:budget/screen/subcategory/screen_subcategory.dart';
import 'package:budget/widget/history/widget_history.dart';
import 'package:budget/widget/no_data.dart';
import 'package:budget/widget/switch_date.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({super.key, required this.groupCategory});

  final GroupCategory groupCategory;

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenCategory(
          providerApp.finance.id, providerApp.switchDate, groupCategory),
      child: Consumer<ProviderScreenCategory>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(provider.titleAppBar()),
            ),
            body: FutureBuilder(
              future: provider.loadData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: [
                    const SizedBox(height: 4),
                    const WidgetInfo(),
                    provider.listGroupSubCategory.isEmpty
                        ? const WidgetNoData()
                        : const WidgetListGroupSubCategory(),
                    provider.listHistoryOperation.isEmpty
                        ? const SizedBox()
                        : WidgetHistory(
                            listHistoryOperation:
                                provider.listHistoryOperation),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenCategory>(context);
    return WidgetSwitchDate(
      titleValue: provider.titleSumOperation(),
      onPressedButBackDate: provider.onPressedButBackDate,
      onPressedButNextDate: provider.onPressedButNextDate,
    );
  }
}

class WidgetListGroupSubCategory extends StatelessWidget {
  const WidgetListGroupSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenCategory>(context);
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'Подкатегории',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.listGroupSubCategory.length,
          itemBuilder: (context, index) {
            return WidgetGroupSubCategory(
              name: provider.titleGroupSubCategory(index),
              value: provider.valueGroupSubCategory(index),
              percent: provider.percentGroupSubCategory(index),
              color: provider.colorGroupSubCategory(index),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenSubCategory(
                      groupSubCategory: provider.groupSubCategory(index),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class WidgetGroupSubCategory extends StatelessWidget {
  const WidgetGroupSubCategory({
    super.key,
    required this.name,
    required this.value,
    required this.percent,
    required this.color,
    required this.onTap,
  });
  final String name;
  final String value;
  final double percent;
  final Color color;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(name),
      trailing: Text(value, style: const TextStyle(fontSize: 14)),
      subtitle: LinearPercentIndicator(
        animation: true,
        lineHeight: 16.0,
        animationDuration: 500,
        percent: percent / 100,
        center: Text(
          '$percent %',
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
        barRadius: const Radius.circular(8),
        progressColor: color,
      ),
    );
  }
}
