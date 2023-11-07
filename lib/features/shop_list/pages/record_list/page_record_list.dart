import 'package:budget/const/actions_update.dart';
import 'package:budget/features/shop_list/dialogs/add_record_list/dialog_add_record_list.dart';
import 'package:budget/features/shop_list/pages/record_list/bloc/page_record_list_bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:budget/sheets/app_shop_list/menu_list/sheet_menu_list.dart';
import 'package:budget/sheets/app_shop_list/menu_record_list/sheet_menu_record_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageRecordList extends StatelessWidget {
  const PageRecordList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageRecordListBloc(shopList),
      child: Builder(builder: (context) {
        final bloc = BlocProvider.of<PageRecordListBloc>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(bloc.shopList.name),
            actions: const [
              ButtonMenuRecordList(),
            ],
          ),
          floatingActionButton: const ButtonAddNewRecordList(),
          body: const ListRecordList(),
        );
      }),
    );
  }
}

class ListRecordList extends StatelessWidget {
  const ListRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PageRecordListBloc>(context);
    return BlocBuilder<PageRecordListBloc, PageRecordListState>(
      bloc: bloc..add(PageRecordListLoadingEvent()),
      builder: (context, state) {
        if (state is PageRecordListLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PageRecordListLoadedState) {
          final listRecordList = state.listRecordList;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listRecordList.length,
            itemBuilder: (context, index) {
              final recordList = listRecordList[index];
              return Card(
                elevation: 0.5,
                child: ListTile(
                  title: Text(
                    recordList.name,
                    style: TextStyle(
                      decoration: recordList.isselected == 0
                          ? TextDecoration.none
                          : TextDecoration.lineThrough,
                    ),
                  ),
                  trailing: Checkbox(
                    value: recordList.isselected == 0 ? false : true,
                    onChanged: (select) {
                      if (select != null) {
                        bloc.add(PageRecordListOnTapEvent(recordList, select));
                      }
                    },
                  ),
                  onLongPress: () async {
                    final StateUpdate stateUpdate = await showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          SheetMenuRecordList(recordList: recordList),
                    );
                    if (stateUpdate == StateUpdate.page) {
                      bloc.add(PageRecordListLoadingEvent());
                    }
                  },
                  onTap: () {
                    final select = recordList.isselected == 0 ? true : false;
                    bloc.add(PageRecordListOnTapEvent(recordList, select));
                  },
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}

class ButtonMenuRecordList extends StatelessWidget {
  const ButtonMenuRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PageRecordListBloc>(context);
    return IconButton(
      onPressed: () async {
        final StateUpdate stateUpdate = await showModalBottomSheet(
          context: context,
          builder: (context) => SheetMenuList(shopList: bloc.shopList),
        );
        if (stateUpdate == StateUpdate.page) {
          bloc.add(PageRecordListLoadingEvent());
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}

class ButtonAddNewRecordList extends StatelessWidget {
  const ButtonAddNewRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PageRecordListBloc>(context);
    return FloatingActionButton.extended(
      label: const Text('Запись'),
      icon: const Icon(Icons.add),
      onPressed: () async {
        final stateUpdate = await showDialog(
          context: context,
          builder: (context) => DialogAddRecordList(shopList: bloc.shopList),
        );

        if (stateUpdate == StateUpdate.page) {
          bloc.add(PageRecordListLoadingEvent());
        }
      },
    );
  }
}
