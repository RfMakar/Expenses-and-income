import 'package:budget/model/category.dart';
import 'package:budget/screen2/add_category/screen_add_categoty.dart';
import 'package:budget/screen2/const/const_color.dart';
import 'package:budget/screen2/home/provider_screen_home.dart';
import 'package:budget/screen2/category/screen_category.dart';
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
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () async {
              //     await Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => ScreenAddCategory(
              //           isSelectedBudget: provider.isSelectedBudget,
              //         ),
              //       ),
              //     );
              //     provider.sceenUpdate();
              //   },
              //   child: const Icon(Icons.add),
              // ),
              appBar: AppBar(
                backgroundColor: ColorApp.colorApp,
                leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: ColorApp.colorIcon,
                    )),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.history,
                        color: ColorApp.colorIcon,
                      ))
                ],
                title: const Column(
                  children: [
                    Text(
                      'Итого',
                      style: TextStyle(color: ColorApp.colorText),
                    ),
                    Text(
                      '- 20 343 р',
                      style: TextStyle(color: ColorApp.colorText),
                    ),
                  ],
                ),
              ),
              body: ListView(
                children: [
                  WidgetInfo(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: ColorApp.colorApp,
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(8),
                      //   topRight: Radius.circular(8),
                      // ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 40),
                        const Text(
                          'Категории',
                          style: TextStyle(
                              color: ColorApp.colorText, fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: ColorApp.colorIcon,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenAddCategory(
                                  isSelectedBudget: provider.isSelectedBudget,
                                ),
                              ),
                            );
                            provider.sceenUpdate();
                          },
                        ),
                      ],
                    ),
                  ),
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
    return Container(
      decoration: const BoxDecoration(
        color: ColorApp.colorApp,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      height: 160,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            toggleButtonFinanse(context),
            toggleButtonsDayMonthYear(context),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '+ 23 000,0 р',
              style: TextStyle(color: ColorApp.colorText, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }

  Widget toggleButtonFinanse(BuildContext context) {
    final widthToggle = MediaQuery.of(context).size.width * (0.77 / 2.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButtons(
          constraints: BoxConstraints(maxHeight: 30, minWidth: widthToggle),
          isSelected: [false, true],
          onPressed: (index) {},
          children: const [
            Center(child: Text('Расходы')),
            Center(child: Text('Доходы')),
          ],
        ),
      ],
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

class WidgetListCategory extends StatelessWidget {
  const WidgetListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenHome>(context);
    return FutureBuilder<List<Category>>(
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
        // showModalBottomSheet(
        //     context: context,
        //     builder: (context) {
        //       return ScreenSubCategory(
        //         category: category,
        //       );
        //     });
      },
      child: Container(
        margin: EdgeInsets.all(4),
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
              offset: Offset(0.5, 0.5), // Shadow position
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
                  borderRadius: BorderRadius.only(
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
              percent: 0.60,
              animation: true,
              center: Text(
                '${category.percent} %',
                style: TextStyle(fontSize: 8),
              ),
              progressColor: Color(int.parse(category.color)),
            ),
            Text('2 000 00 руб'),
          ],
        ),
      ),
    );
  }
}

/*
InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return ScreenSubCategory(
                category: category,
              );
            });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(int.parse(category.color)),
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category.name,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              '${category.percent} %',
              style: const TextStyle(fontSize: 16),
            ),
            Text('${category.value} руб'),
          ],
        ),
      ),
    );

*/
