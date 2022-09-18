import 'package:budget/screen/list/shop_list/model_shop_list.dart';
import 'package:budget/screen/list/shop_list/screen_model_shop_list.dart';
import 'package:budget/screen/widget/bottom_sheet_del_edit.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/roster.dart';
import 'package:budget/screen/widget/my_widget.dart';
import 'package:provider/provider.dart';

class ScreenShopList extends StatelessWidget {
  const ScreenShopList({Key? key, required this.roster}) : super(key: key);
  final Roster roster;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScreenModelShopList(roster),
      child: Builder(builder: (context) {
        var model = context.read<ScreenModelShopList>();
        return Scaffold(
          appBar: AppBar(
            title: Text(roster.name),
            actions: [
              IconButton(
                  onPressed: () => onPressedActButton(
                        context,
                        model.onTapMenuDeleteSelect,
                        model.onTapMenuDeleteAll,
                      ),
                  icon: const Icon(Icons.more_vert))
            ],
          ),
          body: Stack(
            children: const [
              ShopListWidget(),
              AddNewProduct(),
            ],
          ),
        );
      }),
    );
  }

  void onPressedActButton(BuildContext context, void Function() onPressedDelSel,
      void Function() onPressedDelAll) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () {
                  onPressedDelSel();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Удалить выбранные'),
              ),
              TextButton.icon(
                onPressed: () {
                  onPressedDelAll();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Удалить всё'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenModelShopList>(
      builder: (_, model, __) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              controller: model.textController,
              decoration: InputDecoration(
                hintText: 'Новая запись',
                suffixIcon: model.addEditButton
                    ? iconButtonAddProduct()
                    : iconButtonEditProduct(),
                errorText: model.errorText(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget iconButtonAddProduct() {
    return Builder(builder: (context) {
      var model = context.read<ScreenModelShopList>();
      return IconButton(
        onPressed: () => model.onPressedIconButtonAddRoster(),
        icon: const Icon(Icons.add),
      );
    });
  }

  Widget iconButtonEditProduct() {
    return Builder(builder: (context) {
      var model = context.read<ScreenModelShopList>();
      return IconButton(
        onPressed: () => model.onPressedIconButtonEditRoster(),
        icon: const Icon(Icons.edit),
      );
    });
  }
}

class ShopListWidget extends StatelessWidget {
  const ShopListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenModelShopList>(
      builder: (_, model, __) => FutureBuilder<List<ModelShopList>>(
        future: model.getList(),
        builder: ((_, snapshot) {
          if (!snapshot.hasData) {
            return MyWidget.widgetLoading();
          } else if (snapshot.data!.isEmpty) {
            return MyWidget.widgetIsEmpty();
          }
          final listModelShop = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.only(
              top: 100,
              left: 8,
              right: 8,
              bottom: 8,
            ),
            itemCount: listModelShop.length,
            itemBuilder: (_, index) {
              final modelShopList = listModelShop[index];
              return Card(
                child: ListTile(
                  title: Text(
                    modelShopList.nameProduct,
                    style: modelShopList.select
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough)
                        : null,
                  ),
                  trailing: Checkbox(
                    onChanged: (_) => model.onTapListTile(modelShopList),
                    value: modelShopList.select,
                  ),
                  onLongPress: () => onLongPressListTile(
                    context,
                    () => model.onLongPressListTileDelete(modelShopList),
                    () => model.onLongPressListTileEdit(modelShopList),
                  ),
                  onTap: () => model.onTapListTile(modelShopList),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  void onLongPressListTile(BuildContext context, void Function() onTapDelete,
      void Function() onTapEdit) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetDelEdit(
        onTapDelete: () {
          onTapDelete();
          Navigator.pop(context);
        },
        onTapEdit: () {
          onTapEdit();
          Navigator.pop(context);
        },
      ),
    );
  }
}
