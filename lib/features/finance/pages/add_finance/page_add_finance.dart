import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/pages/material_app/model_material_app.dart';
import 'package:budget/features/finance/dialogs/add_category/dialog_add_category.dart';
import 'package:budget/features/finance/dialogs/add_operation/dialog_add_operation.dart';
import 'package:budget/features/finance/dialogs/add_subcategory/dialog_add_subcategory.dart';
import 'package:budget/features/finance/pages/add_finance/model_page_add_finance.dart';
import 'package:budget/features/finance/pages/add_finance/model_widget_card_category.dart';
import 'package:budget/features/finance/sheets/menu_category/sheet_menu_category.dart';
import 'package:budget/features/finance/sheets/menu_subcategory/sheet_menu_subcategory.dart';
import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageAddFinance extends StatelessWidget {
  const PageAddFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final modelApp = context.read<ModelMaterialApp>();
    return ChangeNotifierProvider(
      create: (context) => ModelPageAddFinance(modelApp.finance),
      child: const ViewPage(),
    );
  }
}

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final model = context.read<ModelPageAddFinance>();
    return Scaffold(
      appBar: AppBar(title: Text(localeApp.listOfCategories)),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(localeApp.category),
        icon: const Icon(Icons.add),
        onPressed: () async {
          final StateUpdate? stateUpdate = await showDialog(
            context: context,
            builder: (context) => const DialogAddCategory(),
          );

          if (stateUpdate == StateUpdate.page) {
            model.updatePage();
          }
        },
      ),
      body: ListView(
        children: const [
          WidgetSwitchFinance(),
          WidgetListCategory(),
        ],
      ),
    );
  }
}

class WidgetSwitchFinance extends StatelessWidget {
  const WidgetSwitchFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final modelApp = context.read<ModelMaterialApp>();
    final model = context.watch<ModelPageAddFinance>();
    final widthToggle = MediaQuery.of(context).size.width * (0.8 / 2.0);
    return Center(
      child: ToggleButtons(
        constraints: BoxConstraints(maxHeight: 30, minWidth: widthToggle),
        isSelected: modelApp.finance.isSelected,
        onPressed: (index) {
          modelApp.finance.onPressed(index);
          model.updatePage();
        },
        children: [
          Center(child: Text(localeApp.expenses)),
          Center(child: Text(localeApp.income)),
        ],
      ),
    );
  }
}

class WidgetListCategory extends StatelessWidget {
  const WidgetListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelPageAddFinance>();
    return FutureBuilder<List<Category>>(
      future: model.getListCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: ListTile());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        final listCategory = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listCategory.length,
          itemBuilder: (context, index) {
            final category = listCategory[index];
            return WidgetCardCategory(
              category: category,
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
    final modelPage = context.read<ModelPageAddFinance>();
    return ChangeNotifierProvider(
      create: (context) => ModelWidgetCardCategory(category),
      builder: (context, child) {
        final modelWidget = context.read<ModelWidgetCardCategory>();
        return Card(
          elevation: 0.5,
          child: InkWell(
            onLongPress: () async {
              final StateUpdate? actionsUpdate = await showModalBottomSheet(
                context: context,
                builder: (context) => SheetMenuCategory(
                  category: category,
                ),
              );
              if (actionsUpdate == StateUpdate.widget) {
                modelWidget.updateWidget();
              } else if (actionsUpdate == StateUpdate.page) {
                modelPage.updatePage();
              }
            },
            child: const WidgetExpansionTileCategory(),
          ),
        );
      },
    );
  }
}

class WidgetExpansionTileCategory extends StatelessWidget {
  const WidgetExpansionTileCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final modelWidget = context.watch<ModelWidgetCardCategory>();
    return FutureBuilder<List<SubCategory>>(
      future: modelWidget.loadListSubCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: ListTile());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        final litSubCategory = snapshot.data!;
        return ExpansionTile(
          key: PageStorageKey(modelWidget.key()),
          title: Builder(builder: (context) {
            return Text(
              context.watch<ModelWidgetCardCategory>().titleCard(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            );
          }),
          controlAffinity: ListTileControlAffinity.leading,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final StateUpdate? stateUpdate = await showDialog(
                context: context,
                builder: (context) =>
                    DialogAddSubCategory(category: modelWidget.category()),
              );
              if (stateUpdate == StateUpdate.widget) {
                modelWidget.updateWidget();
              }
            },
          ),
          children: litSubCategory.map((subCategory) {
            return WidgetCardSubCategory(subCategory: subCategory);
          }).toList(),
        );
      },
    );
  }
}

class WidgetCardSubCategory extends StatelessWidget {
  const WidgetCardSubCategory({super.key, required this.subCategory});
  final SubCategory subCategory;
  @override
  Widget build(BuildContext context) {
    final modelWidget = context.read<ModelWidgetCardCategory>();
    return ListTile(
      iconColor: Color(modelWidget.colorCatgory()),
      leading: const Icon(Icons.navigate_next),
      title: Text(
        subCategory.name,
        style: TextStyle(
          fontSize: 14,
          color: Color(modelWidget.colorCatgory()),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => DialogAddOperation(subCategory: subCategory),
        );
      },
      onLongPress: () async {
        final StateUpdate? actionsUpdate = await showModalBottomSheet(
          context: context,
          builder: (context) => SheetMenuSubCategory(subCategory: subCategory),
        );
        if (actionsUpdate == StateUpdate.widget) {
          modelWidget.updateWidget();
        }
      },
    );
  }
}
