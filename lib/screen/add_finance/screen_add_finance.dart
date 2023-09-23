import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/add_category/dialog_add_category.dart';
import 'package:budget/models/categories.dart';
import 'package:budget/screen/add_finance/provider_screen_add_finance.dart';
import 'package:budget/screen/widget/switch_finance.dart';
import 'package:budget/sheets/menu_category/sheet_menu_category.dart';
import 'package:budget/sheets/menu_subcategory/sheet_menu_subcategory.dart';
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
                      builder: (context) =>
                          DialogAddCategory(idfinance: provider.finance),
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
    return WidgetSwitchFinance(
        isSelected: provider.isSelectedFinance,
        onPressed: provider.onPressedButFinance);
  }
}

class WidgetCategories extends StatelessWidget {
  const WidgetCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenAddFinance>(context);
    return FutureBuilder(
      future: provider.getListCategory(),
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
                              builder: (context) => SheetMenuSubCategory(
                                subCategory: subCategories,
                                financeSwitch: providerScreen.finance,
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
