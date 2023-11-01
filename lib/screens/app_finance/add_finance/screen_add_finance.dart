import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/app_finance/add_category/dialog_add_category.dart';
import 'package:budget/dialogs/app_finance/add_operation/dialog_add_operation.dart';
import 'package:budget/dialogs/app_finance/add_subcategory/dialog_add_subcategory.dart';
import 'package:budget/models/app_finance/categories.dart';
import 'package:budget/provider_app.dart';
import 'package:budget/screens/app_finance/add_finance/provider_screen_add_finance.dart';
import 'package:budget/screens/app_finance/add_finance/provider_widget_card_category.dart';
import 'package:budget/sheets/app_finance/menu_category/sheet_menu_category.dart';
import 'package:budget/sheets/app_finance/menu_subcategory/sheet_menu_subcategory.dart';
import 'package:budget/widget/switch_finance.dart';
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
            appBar: AppBar(title: const Text('Категории')),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                final bool? update = await showDialog(
                  context: context,
                  builder: (context) => const DialogAddCategory(),
                );

                if (update == true) {
                  provider.updateScreen();
                }
              },
              label: const Text('Категория'),
              icon: const Icon(Icons.add),
            ),
            body: ListView(
              children: const [
                WidgetSwitchFinance(),
                WidgetListCategory(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WidgetListCategory extends StatelessWidget {
  const WidgetListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    final provider = Provider.of<ProviderScreenAddFinance>(context);
    return FutureBuilder(
      future: provider.getListCategory(providerApp.finance.id),
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
          itemCount: provider.listCategory.length,
          itemBuilder: (context, index) {
            return WidgetCardCategory(
              category: provider.selectCategory(index),
            );
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
    final providerScreen = Provider.of<ProviderScreenAddFinance>(context);
    return ChangeNotifierProvider(
      create: (context) => ProviderWidgetCardCategory(category),
      child: Consumer<ProviderWidgetCardCategory>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.getListSubCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const ListTile();
              }
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              return Card(
                elevation: 0.5,
                child: InkWell(
                  onLongPress: () async {
                    final ActionsUpdate? actionsUpdate =
                        await showModalBottomSheet(
                      context: context,
                      builder: (context) => SheetMenuCategory(
                        category: provider.category,
                      ),
                    );
                    if (actionsUpdate == ActionsUpdate.updateWidget) {
                      provider.updateWidget();
                    } else if (actionsUpdate == ActionsUpdate.updateScreen) {
                      providerScreen.updateScreen();
                    }
                  },
                  child: ExpansionTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    trailing: IconButton(
                      onPressed: () async {
                        final bool? update = await showDialog(
                          context: context,
                          builder: (context) =>
                              DialogAddSubCategory(category: provider.category),
                        );
                        if (update == true) {
                          provider.updateWidget();
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    key: PageStorageKey(provider.key()),
                    textColor: provider.colorCategories(),
                    iconColor: provider.colorCategories(),
                    title: Text(
                      provider.nameCategories(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    children: provider
                        .listNameSubcategories()
                        .map(
                          (subCategories) => ListTile(
                            //iconColor: provider.colorCategories(),
                            // leading: const Icon(Icons.navigate_next_outlined),
                            title: Text(
                              subCategories.name,
                              style: TextStyle(
                                fontSize: 14,
                                //color: provider.colorCategories(),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => DialogAddOperation(
                                    subCategory: subCategories),
                              );
                            },
                            onLongPress: () async {
                              final ActionsUpdate? actionsUpdate =
                                  await showModalBottomSheet(
                                context: context,
                                builder: (context) => SheetMenuSubCategory(
                                    subCategory: subCategories),
                              );
                              if (actionsUpdate == ActionsUpdate.updateWidget) {
                                provider.updateWidget();
                              }
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
