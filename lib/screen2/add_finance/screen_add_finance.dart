import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/add_categories/dialog_add_categories.dart';
import 'package:budget/model/categories.dart';
import 'package:budget/screen2/add_finance/provider_screen_add_finance.dart';
import 'package:budget/screen2/widget/switch_expence_income.dart';
import 'package:budget/sheets/menu_categories/sheet_menu_categories.dart';
import 'package:budget/sheets/menu_subcategories/sheet_menu_subcategories.dart';
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
              title: const Text('Категории'),
              actions: [
                IconButton(
                  onPressed: () async {
                    final bool? update = await showDialog(
                      context: context,
                      builder: (context) => DialogAddCategories(
                          idfinance: provider.financeSwitch()),
                    );

                    if (update == true) {
                      provider.updateScreen();
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            body: ListView(
              children: const [
                WidgetFinance(),
                WidgetCategories(),
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

class WidgetCategories extends StatelessWidget {
  const WidgetCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenAddFinance>(context);
    return FutureBuilder(
      future: provider.getListCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.listCategories.length,
          itemBuilder: (context, index) {
            return WidgetCardCategory(
              categories: provider.selectCategories(index),
            );
          },
        );
      },
    );
  }
}

class WidgetCardCategory extends StatelessWidget {
  const WidgetCardCategory({super.key, required this.categories});
  final Categories categories;
  @override
  Widget build(BuildContext context) {
    final providerScreen = Provider.of<ProviderScreenAddFinance>(context);
    return ChangeNotifierProvider(
      create: (context) => ProviderWidgetCardCategory(categories),
      child: Consumer<ProviderWidgetCardCategory>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.getListSubCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              return Card(
                child: ExpansionTile(
                  childrenPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () async {
                      final ActionsUpdate? actionsUpdate =
                          await showModalBottomSheet(
                        context: context,
                        builder: (context) => SheetMenuCategories(
                          categories: provider.categories,
                        ),
                      );
                      if (actionsUpdate == ActionsUpdate.updateWidget) {
                        provider.updateWidget();
                      } else if (actionsUpdate == ActionsUpdate.updateScreen) {
                        providerScreen.updateScreen();
                      }
                    },
                  ),
                  key: PageStorageKey(provider.key()),
                  textColor: provider.colorCategories(),
                  iconColor: provider.colorCategories(),
                  title: Text(provider.nameCategories()),
                  children: provider
                      .listNameSubcategories()
                      .map(
                        (subCategories) => ListTile(
                          textColor: provider.colorCategories(),
                          iconColor: provider.colorCategories(),
                          leading: const Icon(Icons.arrow_right),
                          title: Text(subCategories.name),
                          onTap: () async {
                            final ActionsUpdate? actionsUpdate =
                                await showModalBottomSheet(
                              context: context,
                              builder: (context) => SheetMenuSubCategories(
                                subCategories: subCategories,
                                financeSwitch: providerScreen.financeSwitch(),
                              ),
                            );
                            if (actionsUpdate == ActionsUpdate.updateWidget) {
                              provider.updateWidget();
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



/*

 
// class WidgetAccount extends StatelessWidget {
//   const WidgetAccount({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProviderScreenAddFinance>(context);
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('Счет'),
//             IconButton(
//               onPressed: () async {
//                 final bool? update = await showDialog(
//                   context: context,
//                   builder: (context) => const DialogAddAccount(),
//                 );

//                 if (update == true) {
//                   provider.updateScreen();
//                 }
//               },
//               icon: const Icon(Icons.add),
//             ),
//           ],
//         ),
//         SizedBox(
//           child: FutureBuilder(
//             future: provider.getListAccount(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState != ConnectionState.done) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (snapshot.hasError) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               return CarouselSlider.builder(
//                 itemCount: provider.listAccounts.length,
//                 carouselController: provider.buttonCarouselController,
//                 options: CarouselOptions(
//                   height: 120,
//                   //aspectRatio: 3.2,
//                   enlargeCenterPage: true,
//                   scrollDirection: Axis.horizontal,
//                   autoPlay: false,
//                 ),
//                 itemBuilder: (context, index, realIndex) {
//                   return Container(
//                       // height: 120,
//                       // constraints: const BoxConstraints(minHeight: 90),
//                       margin: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(color: provider.colorAccount(index)),
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: [
//                           BoxShadow(
//                             color: provider.colorAccount(index),
//                             blurRadius: 1,
//                             offset: const Offset(0.5, 0.5),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 40,
//                             constraints: const BoxConstraints(minWidth: 90),
//                             decoration: BoxDecoration(
//                                 color: provider.colorAccount(index),
//                                 borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(6),
//                                     topRight: Radius.circular(6))),
//                             child: Center(
//                               child: Text(provider.nameAccount(index)),
//                             ),
//                           ),
//                           Expanded(
//                             child: Center(
//                               child: Text(provider.valueAccount(index)),
//                             ),
//                           ),
//                         ],
//                       ));
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

/*
ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.listAccounts.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container();
                          });
                    },
                    onTap: () {
                      provider.onTapAccount(index);
                    },
                    child: Container(
                        //width: 90,
                        constraints: const BoxConstraints(minWidth: 90),
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: provider.selectionAccount(index) == 1
                              ? provider.colorAccount(index)
                              : Colors.white,
                          border:
                              Border.all(color: provider.colorAccount(index)),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: provider.colorAccount(index),
                              blurRadius: 1,
                              offset: const Offset(0.5, 0.5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              constraints: const BoxConstraints(minWidth: 90),
                              decoration: BoxDecoration(
                                  color: provider.colorAccount(index),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6))),
                              child: Center(
                                child: Text(provider.nameAccount(index)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(provider.valueAccount(index)),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              );

*/

*/
