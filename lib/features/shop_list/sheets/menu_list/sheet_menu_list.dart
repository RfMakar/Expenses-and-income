import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/shop_list/sheets/menu_list/bloc/sheet_menu_list_bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SheetMenuList extends StatelessWidget {
  const SheetMenuList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SheetMenuListBloc(shopList),
        child: BlocListener<SheetMenuListBloc, SheetMenuListState>(
          listener: (context, state) {
            if (state is SheetMenuListMarkState) {
              Navigator.pop(context, StateUpdate.page);
            }
            if (state is SheetMenuListRestoreState) {
              Navigator.pop(context, StateUpdate.page);
            }
            if (state is SheetMenuListDeleteState) {
              Navigator.pop(context, StateUpdate.page);
            }
            if (state is SheetMenuListClearState) {
              Navigator.pop(context, StateUpdate.page);
            }
          },
          child: const SheetView(),
        ));
  }
}

class SheetView extends StatelessWidget {
  const SheetView({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final bloc = BlocProvider.of<SheetMenuListBloc>(context);
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.check_box_outlined),
          title: Text(localeApp.selectAll),
          onTap: () {
            bloc.add(SheetMenuListOnPresButMarkEvent());
          },
        ),
        ListTile(
          leading: const Icon(Icons.check_box_outline_blank),
          title: Text(localeApp.restoreAll),
          onTap: () {
            bloc.add(SheetMenuListOnPresButRestoreEvent());
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete_outline),
          title: Text(localeApp.removeSelected),
          onTap: () {
            bloc.add(SheetMenuListOnPresButDeleteEvent());
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete_forever_outlined),
          title: Text(localeApp.clearTheList),
          onTap: () {
            bloc.add(SheetMenuListOnPresButClearEvent());
          },
        ),
      ],
    );
  }
}
