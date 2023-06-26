import 'package:budget/screen2/add_category/screen_add_categoty.dart';
import 'package:budget/screen2/add_finance/provider_screen_add_finance.dart';
import 'package:budget/screen2/widget/switch_expence_income.dart';
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
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenAddCategory(
                      isSelectedBudget: provider.finance,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
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
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: SwitchExpensesIncome(
        onPressedCallBack: provider.onPressedSwitchExpInc,
      ),
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
            return InkWell(
              onLongPress: () {
                print('меню');
              },
              child: ExpansionTile(
                textColor: provider.colorCategories(index),
                iconColor: provider.colorCategories(index),
                collapsedTextColor: provider.colorCategories(index),
                collapsedIconColor: provider.colorCategories(index),
                title: Text(
                  provider.nameCategories(index),
                ),
                children: provider
                    .nameSubCategories(index)
                    .map(
                      (e) => ListTile(
                        title: Text(e),
                        onTap: () {},
                      ),
                    )
                    .toList(),
              ),
            );
          },
        );
      },
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


// class WidgetValueNote extends StatelessWidget {
//   const WidgetValueNote({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProviderScreenAddFinance>(context);
//     return Container(
//       margin: const EdgeInsets.all(8),
//       // padding: const EdgeInsets.all(8),
//       // decoration: const BoxDecoration(
//       //   color: Colors.white,
//       //   borderRadius: BorderRadius.all(Radius.circular(8)),
//       //   boxShadow: [
//       //     BoxShadow(
//       //       color: Colors.blue,
//       //       blurRadius: 2,
//       //       offset: Offset(1, 1), // Shadow position
//       //     ),
//       //   ],
//       // ),
//       child: Column(
//         children: [
//           Row(
//             children: const [
//               Text('Сумма'),
//             ],
//           ),
//           TextFieldValue(
//               textEditingController: provider.textEditingControllerValue),
//           const SizedBox(height: 8),
//           Row(
//             children: const [
//               Text('Заметка'),
//             ],
//           ),
//           const TextField(
//             keyboardType: TextInputType.text,
//             textCapitalization: TextCapitalization.sentences,
//             textAlign: TextAlign.center,
//             decoration: InputDecoration(
//               isDense: true,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(16)),
//                 borderSide: BorderSide(
//                   color: Colors.blue,
//                   width: 2,
//                 ),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(16)),
//                 borderSide: BorderSide(width: 2),
//                 gapPadding: 0,
//               ),
//               hintText: '...',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


*/
