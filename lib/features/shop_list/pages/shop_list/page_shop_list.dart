import 'package:budget/const/actions_update.dart';
import 'package:budget/features/shop_list/dialogs/add_shop_list/dialog_add_shop_list.dart';
import 'package:budget/features/shop_list/pages/record_list/page_record_list.dart';
import 'package:budget/features/shop_list/pages/shop_list/bloc/page_shop_list_bloc.dart';
import 'package:budget/features/shop_list/sheets/menu_shop_list/sheet_menu_shop_list.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageShopList extends StatelessWidget {
  const PageShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageShopListBloc()..add(PageShopListLoadingEvent()),
      child: const Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          ListShopList(),
          ButtonAddShopList(),
        ],
      ),
    );
  }
}

class ListShopList extends StatelessWidget {
  const ListShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageShopListBloc, PageShopListState>(
      builder: (context, state) {
        if (state is PageShopListLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PageShopListLoadedState) {
          return ListView.builder(
            itemCount: state.listShopList.length,
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 50),
            itemBuilder: (context, index) {
              return WidgetCardShopList(shopList: state.listShopList[index]);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class WidgetCardShopList extends StatelessWidget {
  const WidgetCardShopList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PageShopListBloc>(context);
    return Card(
      elevation: 0.5,
      child: ListTile(
        title: Text(shopList.name),
        trailing: const Icon(Icons.navigate_next_outlined),
        onLongPress: () async {
          final StateUpdate? stateUpdate = await showModalBottomSheet(
            context: context,
            builder: (context) => SheetMenuShopList(
              shopList: shopList,
            ),
          );
          if (stateUpdate == StateUpdate.page) {
            bloc.add(PageShopListLoadingEvent());
          }
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageRecordList(shopList: shopList),
            ),
          );
        },
      ),
    );
  }
}

class ButtonAddShopList extends StatelessWidget {
  const ButtonAddShopList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PageShopListBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FloatingActionButton.extended(
        label: const Text('Список'),
        icon: const Icon(Icons.add),
        onPressed: () async {
          final StateUpdate? stateUpdate = await showDialog(
            context: context,
            builder: (context) => const DialogAddShopList(),
          );
          if (stateUpdate == StateUpdate.page) {
            bloc.add(PageShopListLoadingEvent());
          }
        },
      ),
    );
  }
}
