import 'package:budget/model/category.dart';
import 'package:budget/screen2/add_finance/screen_add_finance.dart';
import 'package:budget/screen2/const/const_color.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: category.colorCategory(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorApp.colorIcon),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          category.name,
          style: const TextStyle(color: ColorApp.colorText),
        ),
        actions: [
          PopupMenuButton(
            child: const Icon(
              Icons.more_vert,
              color: ColorApp.colorIcon,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history),
                      SizedBox(
                        width: 8,
                      ),
                      Text('История'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Удалить'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Изменить'),
                    ],
                  ),
                ),
              ];
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenAddFinace(category: category),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          WidgetInfo(
            category: category,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: category.colorCategory(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                const Text(
                  'Подкатегории',
                  style: TextStyle(color: ColorApp.colorText, fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: ColorApp.colorIcon,
                  ),
                  onPressed: () async {},
                ),
              ],
            ),
          ),
          WidgetListSubCategory(
            category: category,
          ),
        ],
      ),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: category.colorCategory(),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            toggleButtonsDayMonthYear(context),
            SizedBox(
              height: 10,
            ),
            const Text(
              '- 20 343 р',
              style: TextStyle(
                  color: ColorApp.colorText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget toggleButtonsDayMonthYear(BuildContext context) {
    final widthToggle = MediaQuery.of(context).size.width * (0.6 / 2.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          splashRadius: 10,
          onPressed: () {},
          icon: const Icon(
            Icons.navigate_before,
            color: ColorApp.colorIcon,
          ),
        ),
        ToggleButtons(
          constraints: BoxConstraints(maxHeight: 30, minWidth: widthToggle),
          isSelected: [true, false],
          onPressed: (index) {},
          children: [
            Center(child: Text('Июнь')),
            Center(child: Text('2023')),
          ],
        ),
        IconButton(
          splashRadius: 10,
          onPressed: () {},
          icon: const Icon(
            Icons.navigate_next,
            color: ColorApp.colorIcon,
          ),
        ),
      ],
    );
  }
}

class WidgetListSubCategory extends StatelessWidget {
  const WidgetListSubCategory({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: category.colorCategory(), width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            onTap: () {},
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$index'),
                Text('2 000 Р'),
              ],
            ),
            subtitle: LinearPercentIndicator(
              animation: true,
              percent: index / 30.0,
              backgroundColor: Colors.grey,
              progressColor: category.colorCategory(),
            ),
          ),
        );
      },
    );
  }
}
