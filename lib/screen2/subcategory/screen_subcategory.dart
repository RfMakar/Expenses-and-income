import 'package:budget/model/category.dart';
import 'package:budget/model/operation.dart';
import 'package:budget/model/subcategory.dart';
import 'package:budget/screen2/const/const_color.dart';
import 'package:budget/screen2/subcategory/provider_screen_subcategory.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ScreenSubCategory extends StatelessWidget {
  const ScreenSubCategory(
      {super.key, required this.category, required this.subCategory});
  final Category category;
  final SubCategory subCategory;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenSubCategory(category, subCategory),
      builder: (context, child) {
        return Consumer<ProviderScreenSubCategory>(
          builder: (context, value, child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: subCategory.colorCategory(),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: ColorApp.colorIcon),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  subCategory.name,
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
                  WidgetInfo(subCategory: subCategory),
                  const WidgetListSubCategory()
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
  const WidgetInfo({super.key, required this.subCategory});
  final SubCategory subCategory;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: subCategory.colorCategory(),
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
  const WidgetListSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenSubCategory>(context);
    return FutureBuilder<List<Operation>>(
      future: provider.getListOperationsy(),
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
                color: provider.subCategory.colorCategory(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
                  const Text(
                    'Операции',
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
                final operation = snapshot.data![index];
                return Card(
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                        BorderSide(color: operation.colorCategory(), width: 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    onTap: () async {
                      // await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         ScreenSubCategory(subCategory: subCategory),
                      //   ),
                      // );
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(operation.date),
                        Text('${operation.value} Р'),
                      ],
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
