import 'package:budget/model/category.dart';
import 'package:budget/screen2/add_category/screen_add_categoty.dart';
import 'package:budget/screen2/add_finance/screen_add_finance.dart';
import 'package:budget/screen2/home/provider_screen_home.dart';
import 'package:budget/screen2/category/screen_category.dart';
import 'package:budget/screen2/widget/switch_date.dart';
import 'package:budget/screen2/widget/switch_expence_income.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenHome(),
      builder: (context, child) => Consumer<ProviderScreenHome>(
        builder: (context, provider, _) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenAddFinance(),
                    ),
                  );
                  provider.screenUpdate();
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                leading:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
                title: const Text('Главная'),
              ),
              body: ListView(
                children: const [
                  WidgetInfo(),
                  WidgetListCategory(),
                ],
              ));
        },
      ),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenHome>(context);
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
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),
      height: 140,
      child: Column(
        children: [
          SwitchExpensesIncome(
            onPressedCallBack: provider.onPressedSwitchExpInc,
          ),
          SwitchDate(
            onPressedCallBack: provider.onPressedSwitchDate,
            titleValue: '20 000',
          ),
        ],
      ),
    );
  }
}

class WidgetListCategory extends StatelessWidget {
  const WidgetListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenHome>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 40),
            const Text('Категории', style: TextStyle(fontSize: 16)),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenAddCategory(
                      isSelectedBudget: provider.isSelectedSwitchExpInc,
                    ),
                  ),
                );
                provider.screenUpdate();
              },
            ),
          ],
        ),
        FutureBuilder<List<Category>>(
          future: provider.getListFinance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                return WidgetCardCategory(category: category);
              },
            );
          },
        ),
      ],
    );
  }
}

class WidgetCardCategory extends StatelessWidget {
  const WidgetCardCategory({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenCategory(category: category),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(
              int.parse(category.color),
            ),
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(int.parse(category.color)),
              blurRadius: 3,
              offset: const Offset(0.5, 0.5), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 25,
              decoration: BoxDecoration(
                  color: Color(int.parse(category.color)),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6))),
              child: Center(
                child: Text(
                  category.name,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            CircularPercentIndicator(
              radius: 20.0,
              lineWidth: 2.0,
              percent: category.percent / 100,
              animation: true,
              center: Text(
                '${category.percent} %',
                style: const TextStyle(fontSize: 8),
              ),
              progressColor: Color(int.parse(category.color)),
            ),
            Text('${category.value} Р'),
          ],
        ),
      ),
    );
  }
}
