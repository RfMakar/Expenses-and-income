import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/features/shop_list/sheets/menu_shop_list/bloc/sheet_menu_shop_list_bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SheetMenuShopList extends StatelessWidget {
  const SheetMenuShopList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SheetMenuShopListBloc(shopList),
      child: BlocListener<SheetMenuShopListBloc, SheetMenuShopListState>(
        listener: (context, state) {
          if (state is SheetMenuShopListRenameState) {
            Navigator.pop(context, StateUpdate.page);
          }
          if (state is SheetMenuShopListDeleteState) {
            Navigator.pop(context, StateUpdate.page);
          }
        },
        child: const Wrap(
          children: [
            TitleDialog(),
            Divider(),
            ButtonRenameShopList(),
            ButtonDeleteShopList(),
          ],
        ),
      ),
    );
  }
}

class TitleDialog extends StatelessWidget {
  const TitleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SheetMenuShopListBloc>(context);
    return ListTile(
      title: Text(bloc.shopList.name),
      subtitle: const Text(
        'Список',
        style: TextStyle(fontSize: 10),
      ),
    );
  }
}

class ButtonRenameShopList extends StatelessWidget {
  const ButtonRenameShopList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SheetMenuShopListBloc>(context);
    return ListTile(
      leading: const Icon(Icons.edit),
      title: const Text('Переименовать'),
      onTap: () async {
        final String? newName = await showDialog(
          context: context,
          builder: (context) => DialogEditName(name: bloc.shopList.name),
        );
        if (newName != null) {
          bloc.add(
              SheetMenuShopListOnPressedButtonRenameShopListEvent(newName));
        }
      },
    );
  }
}

class ButtonDeleteShopList extends StatelessWidget {
  const ButtonDeleteShopList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SheetMenuShopListBloc>(context);
    return ListTile(
      leading: const Icon(Icons.delete),
      title: const Text('Удалить'),
      onTap: () async {
        final bool result = await showDialog(
          context: context,
          builder: (context) => const DialodgDelete(),
        );
        if (result == true) {
          bloc.add(SheetMenuShopListOnPressedButtonDeleteShopListEvent());
        }
      },
    );
  }
}
