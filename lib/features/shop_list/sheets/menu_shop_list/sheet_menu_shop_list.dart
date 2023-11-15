import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/dialogs/delete/dialog_delete.dart';
import 'package:budget/features/app/dialogs/edit_name/dialog_edit_name.dart';
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
        child: const SheetView(),
      ),
    );
  }
}

class SheetView extends StatelessWidget {
  const SheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      children: [
        TitleSheet(),
        Divider(),
        ButtonRenameShopList(),
        ButtonDeleteShopList(),
      ],
    );
  }
}

class TitleSheet extends StatelessWidget {
  const TitleSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetMenuShopListBloc, SheetMenuShopListState>(
      builder: (context, state) {
        if (state is SheetMenuShopListInitial) {
          return ListTile(
            title: Text(state.shopList.name),
            subtitle: const Text(
              'Список',
              style: TextStyle(fontSize: 10),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ButtonRenameShopList extends StatelessWidget {
  const ButtonRenameShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetMenuShopListBloc, SheetMenuShopListState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<SheetMenuShopListBloc>(context);
        if (state is SheetMenuShopListInitial) {
          return ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Переименовать'),
            onTap: () async {
              final String? newName = await showDialog(
                context: context,
                builder: (context) =>
                    DialogEditName(nameEdit: state.shopList.name),
              );
              if (newName != null) {
                bloc.add(SheetMenuShopListRenameEvent(newName));
              }
            },
          );
        } else {
          return Container();
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
        final bool? result = await showDialog(
          context: context,
          builder: (context) => const DialodgDelete(),
        );
        if (result == true) {
          bloc.add(SheetMenuShopListDeleteEvent());
        }
      },
    );
  }
}
