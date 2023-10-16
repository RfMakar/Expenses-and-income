import 'package:budget/provider_app.dart';
import 'package:budget/screen/add_finance/screen_add_finance.dart';
import 'package:budget/screen/category/screen_category.dart';
import 'package:budget/screen/finance/provider_screen_finance.dart';
import 'package:budget/widget/history/widget_history.dart';
import 'package:budget/widget/no_data.dart';
import 'package:budget/widget/switch_date.dart';
import 'package:budget/widget/switch_finance.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ScreenFinance extends StatelessWidget {
  const ScreenFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenFinance(providerApp.switchDate),
      child: Consumer<ProviderScreenFinance>(
        builder: (context, provider, _) {
          return FutureBuilder(
            future: provider.loadData(providerApp.finance.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              return Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(4, 20, 4, 50),
                    children: [
                      const WidgetSwitchFinance(),
                      const WidgetInfo(),
                      provider.listGroupCategory.isEmpty
                          ? const WidgetNoData()
                          : const WidgetListGroupCategory(),
                      provider.listHistoryOperation.isEmpty
                          ? const SizedBox()
                          : WidgetHistory(
                              listHistoryOperation:
                                  provider.listHistoryOperation,
                            ),
                    ],
                  ),
                  const ButtonAddFinance(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class ButtonAddFinance extends StatelessWidget {
  const ButtonAddFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenFinance>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenAddFinance(),
            ),
          );
          provider.updateScreen();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenFinance>(context);

    return WidgetSwitchDate(
      titleValue: provider.titleSumOperation(),
      onPressedButBackDate: provider.onPressedButBackDate,
      onPressedButNextDate: provider.onPressedButNextDate,
    );
  }
}

class WidgetListGroupCategory extends StatelessWidget {
  const WidgetListGroupCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenFinance>(context);
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'Категории',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: provider.listGroupCategory.length,
          itemBuilder: (context, index) {
            return WidgetGroupCategory(
              color: provider.colorGroupCategory(index),
              name: provider.titleGroupCategory(index),
              percent: provider.percentGroupCategory(index),
              value: provider.valueGroupCategory(index),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenCategory(
                      groupCategory: provider.groupCategory(index),
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

class WidgetGroupCategory extends StatelessWidget {
  const WidgetGroupCategory({
    super.key,
    required this.color,
    required this.name,
    required this.percent,
    required this.value,
    required this.onTap,
  });
  final Color color;
  final String name;
  final double percent;
  final String value;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    name,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            CircularPercentIndicator(
              radius: 24.0,
              lineWidth: 6.0,
              percent: percent / 100,
              animation: true,
              center: Text(
                '$percent %',
                style: const TextStyle(fontSize: 10),
              ),
              progressColor: color,
            ),
            Container(
              height: 25,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
