import 'package:flutter/material.dart';

class PageRecordList extends StatelessWidget {
  const PageRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


/*
class ScreenRecordList extends StatelessWidget {
  const ScreenRecordList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenRecordlist(shopList),
      builder: (context, child) {
        final provider = context.read<ProviderScreenRecordlist>();
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.titleAppBar()),
            actions: [
              IconButton(
                onPressed: () async {
                  final StateUpdate? actionsUpdate = await showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        SheetMenuList(shopList: provider.shopList),
                  );
                  if (actionsUpdate == StateUpdate.page) {
                    provider.updateScreen();
                  }
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          floatingActionButton: const ButtonAddNewRecordList(),
          body: const ListRecordList(),
        );
      },
    );
  }
}

class ButtonAddNewRecordList extends StatelessWidget {
  const ButtonAddNewRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProviderScreenRecordlist>();
    return FloatingActionButton.extended(
      label: const Text('Запись'),
      icon: const Icon(Icons.add),
      onPressed: () async {
        bool result = await showDialog(
          context: context,
          builder: (context) =>
              DialogAddRecordList(shopList: provider.shopList),
        );
        if (result) {
          provider.updateScreen();
        }
      },
    );
  }
}

class ListRecordList extends StatelessWidget {
  const ListRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProviderScreenRecordlist>();
    return FutureBuilder(
      future: provider.getListRecord(),
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
          itemCount: provider.listRecordList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.5,
              child: ListTile(
                title: Text(
                  provider.titleCardRecordList(index),
                  style: TextStyle(
                    decoration: provider.valueSelectRecordList(index)
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: Checkbox(
                  value: provider.valueSelectRecordList(index),
                  onChanged: (select) {
                    provider.onChangedListTile(select!, index);
                  },
                ),
                onLongPress: () async {
                  final StateUpdate? actionsUpdate = await showModalBottomSheet(
                    context: context,
                    builder: (context) => SheetMenuRecordList(
                        recordList: provider.recordList(index)),
                  );
                  if (actionsUpdate == StateUpdate.page) {
                    provider.updateScreen();
                  }
                },
                onTap: () => provider.onTapSelectListTile(index),
              ),
            );
          },
        );
      },
    );
  }
}


*/