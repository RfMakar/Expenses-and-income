import 'package:budget/models/categories.dart';
import 'package:budget/screen2/category/provider_screen_category.dart';
import 'package:budget/screen2/widget/switch_date.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory(
      {super.key,
      required this.finance,
      required this.dateTime,
      required this.groupCategory});
  final int finance;
  final DateTime dateTime;
  final GroupCategory groupCategory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ProviderScreenCategory(finance, dateTime, groupCategory),
      builder: (context, child) => Consumer<ProviderScreenCategory>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Column(
                children: [
                  Text(
                    provider.titleAppBar(),
                    style: const TextStyle(fontSize: 10),
                  ),
                  FutureBuilder(
                    future: provider.getSumOperationCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Text(
                        provider.titleSumOperatin(),
                        style: TextStyle(
                          color: provider.colorSumOperation(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            body: ListView(
              children: const [
                SizedBox(height: 4),
                WidgetInfo(),
                WidgetListGroupCategory(),
              ],
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
    return Card(
      child: Column(
        children: [
          SwitchDate(
            onPressedCallBack: provider.onPressedSwitchDate,
            dateTime: provider.dateTime,
          ),
        ],
      ),
    );
  }
}

class WidgetListGroupCategory extends StatelessWidget {
  const WidgetListGroupCategory({super.key});

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
        FutureBuilder(
          future: provider.getListGroupSubCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }

            return provider.listGroupSubCategory.isEmpty
                ? const SizedBox(
                    height: 60,
                    child: Center(
                        child: Text('В этом месяце нет данных, нажмите "+".')),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.listGroupSubCategory.length,
                    itemBuilder: (context, index) {
                      return WidgetGroupSubCategory(
                        name: provider.titleGroupSubCategory(index),
                        value: provider.valueGroupSubCategory(index),
                        percent: provider.percentGroupSubCategory(index),
                        color: provider.colorGroupSubCategory(index),
                        onTap: () {},
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
