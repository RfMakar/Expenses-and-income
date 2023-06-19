import 'package:budget/model/category.dart';
import 'package:budget/model/subcategory.dart';
import 'package:budget/screen2/category/provider_screen_category.dart';
import 'package:budget/screen2/const/const_color.dart';
import 'package:budget/screen2/subcategory/screen_subcategory.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenCategory(category),
      builder: (context, child) {
        return Consumer<ProviderScreenCategory>(
          builder: (context, provider, child) {
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
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
              body: ListView(
                children: [
                  WidgetInfo(category: category),
                  const SizedBox(height: 20),
                  const WidgetListSubCategory(),
                ],
              ),
            );
          },
        );
      },
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
            const SizedBox(height: 10),
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
          isSelected: const [true, false],
          onPressed: (index) {},
          children: const [
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
  const WidgetListSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenCategory>(context);
    return FutureBuilder<List<SubCategory>>(
      future: provider.getListSubCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: provider.category.colorCategory(),
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final subCategory = snapshot.data![index];
                return Card(
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: subCategory.colorCategory(), width: 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenSubCategory(
                              category: provider.category,
                              subCategory: subCategory),
                        ),
                      );
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(subCategory.name),
                        Text('${subCategory.value} Р'),
                      ],
                    ),
                    subtitle: LinearPercentIndicator(
                      animation: true,
                      percent: subCategory.percent / 100.0,
                      backgroundColor: Colors.grey,
                      progressColor: subCategory.colorCategory(),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
